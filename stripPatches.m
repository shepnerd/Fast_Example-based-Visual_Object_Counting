function [ patchFeat, patchRaw, patchDen ] = stripPatches( dataset, patchSize, patchStep )
% extract features, raw data, density map in patch form from the dataset
% based on the patchSize and patchStep.
patchFeat = [];
patchRaw = [];
patchDen = [];

nTr = length(dataset.features);

for i = 1 : nTr
    disp(['Extract patches from training sample #' num2str(i) ...
        ' (out of ' num2str(nTr) ')...']);
    [feats, ~] = getTrainingPatches(dataset.features{i}, ...
        dataset.gtDensities{i}, patchSize, patchStep);
    patchFeat = [patchFeat; feats];
    
    [raws, ~] = getTrainingPatches(dataset.images{i}, ...
        dataset.gtDensities{i}, patchSize, patchStep);
    patchRaw = [patchRaw; raws];
    
    [dens, ~] = getTrainingPatches(dataset.gtDensities{i}, ...
        dataset.gtDensities{i}, patchSize, patchStep);
    patchDen = [patchDen; dens];
end

end

