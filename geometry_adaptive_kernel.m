function [ density ] = geometry_adaptive_kernel( coordinates, img_sz, beta )
% coordinates: a matrix of n*2, in which each row stands for a point with x and y

if ~exist('beta','var')
    beta = 0.3;
end
hei = img_sz(1); wid = img_sz(2);
coordinates = floor(abs(coordinates));

dist2 = @(i,j)((coordinates(i,1)-coordinates(j,1)).^2+(coordinates(i,2)-coordinates(j,2)).^2);
dist = @(i,j)(dist2(i,j).^0.5);
n = size(coordinates,1);
matDist = zeros(n,n);
for i = 1 : n
    for j = i+1 : n
        matDist(i,j) = dist(i,j);
    end
end
matDist = matDist + matDist';

coordinates = int32(coordinates);

density = zeros(hei,wid);
k = 5;
for i = 1 : n
    delta = zeros(hei,wid);
    r = max(min(coordinates(i,2),hei),1);
    c = max(min(coordinates(i,1),wid),1);
    delta(r,c) = 1;
    
    dv = matDist(i,:);
    dv(i) = inf;
    
    d = 0;
    for j = 1 : k
        [tmp, idx] = min(dv);
        d = d + tmp;
        dv(idx) = inf;
    end
    d = d ./ k;
    sigma = beta*d;
    hsize = max(floor(4 * sigma),3);
    f = fspecial('gaussian',hsize,sigma);
    delta = imfilter(delta, f);
    density = density + delta;
end

end

