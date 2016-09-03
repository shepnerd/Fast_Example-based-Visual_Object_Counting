function [ features, respCount ] = getTrainingPatches( gradIm, denIm, patch_size, patch_step)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[row, col, gNum] = size(gradIm);

xrow = 1:patch_step:row-patch_size+1;
ycol = 1:patch_step:col-patch_size+1;
xlen = length(xrow);
ylen = length(ycol);

features = zeros(xlen*ylen,patch_size^2*gNum);
respCount = zeros(xlen*ylen,1);

for x = 1:xlen
    for y = 1:ylen
        r = xrow(x);
        c = ycol(y);
        feaPatch = gradIm(r:r+patch_size-1,c:c+patch_size-1,:);
        denPatch = denIm(r:r+patch_size-1,c:c+patch_size-1);
        idx = (x-1)*ylen+y;
        features(idx,:) = feaPatch(:)';
        respCount(idx) = sum(denPatch(:));
    end
end

end

