function [ density ] = genDensityMap( loc_map, hsize, sigma)
% loc_map : an image marks the locations of object, where 0 means none and
% 1 (or > 1) means the location.
% hsize   : the influential range of the guassian kernel, usually 4.0*6
% sigma   : the standard error of the guassian kernel, usually 4.0
% density : the density map of the given location map. Usually, the
% integral of the whole density map is equal to or smaller than that of the
% location map.
if size(loc_map,3) == 3
    loc_map = rgb2gray(loc_map);
end
m = double(max(loc_map(:)));
loc_map = double(loc_map)./m;
density = imfilter(loc_map, fspecial('gaussian', hsize, sigma));

end

