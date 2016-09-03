function showNeighborhood(centroids, Dict, folder)

if ~exist(folder,'dir')
    mkdir(folder);
end

cnt = size(centroids, 1);
p = sqrt(size(centroids, 2));
for i = 1 : cnt
    patch = centroids(i, :);
    patch = uint8(reshape(patch, [p, p]));
    patch = imresize(patch, 8, 'nearest');
    
    imwrite(patch, [folder filesep num2str(i) '.bmp']);
end

end

