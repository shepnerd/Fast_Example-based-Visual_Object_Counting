function [ trSet, teSet ] = genTrTe( data, params )
% split data into training set and testing set according to the protocols
% in the params

trFeatureCandidates = data.features(params.trRange);
trImageCandidates = data.images(params.trRange);
trGtDenCandidates = data.gtDensities(params.trRange);

trIdx = randperm(length(params.trRange),params.nTrain);
trSet.features = trFeatureCandidates(trIdx);
trSet.images = trImageCandidates(trIdx);
trSet.gtDensities = trGtDenCandidates(trIdx);

teFeatureCandidates = data.features(params.teRange);
teImageCandidates = data.images(params.teRange);
teGtDenCandidates = data.gtDensities(params.teRange);

teIdx = randperm(length(params.teRange),params.nTest);
teSet.features = teFeatureCandidates(teIdx);
teSet.images = teImageCandidates(teIdx);
teSet.gtDensities = teGtDenCandidates(teIdx);

end

