function [ cnt, denImg, synImg, cntMat ] = FEVOCounting( im, dict, centroids, patchSize, patchStep)
% im : query image
% patch_size : as its name depicts
% patch_step : as its name depicts
[h, w] = size(im);

gridx = 1 : patchStep : w - patchSize + 1;
gridy = 1 : patchStep : h - patchSize + 1;

denImg = zeros(size(im));
synImg = zeros(size(im));
cntMat = zeros(size(im));

cc = 0;
tic;

centroids = centroids';
nAtom = size(centroids,2);

% t1 = 0; %% time recording
% t2 = 0; %% tiem recording

for ii = 1 : length(gridx)
    for jj = 1 : length(gridy)
%         tic; %% time recording
        
        xx = gridx(ii);
        yy = gridy(jj);
        patch = single(im(yy : yy + patchSize - 1, xx : xx + patchSize - 1, :));
        featVec = patch(:);
        
%         t1 = t1 + toc; %% time recording
        
        [~,idx] = min(sum((centroids - repmat(featVec, [1, nAtom])).^2));
        estDenPatch = dict(:,:,idx(1)) * featVec;
        
        denImg(yy:yy+patchSize-1,xx:xx+patchSize-1) = denImg(yy:yy+patchSize-1,xx:xx+patchSize-1)+reshape(estDenPatch,[patchSize,patchSize]);
        cntMat(yy:yy+patchSize-1,xx:xx+patchSize-1) = cntMat(yy:yy+patchSize-1,xx:xx+patchSize-1)+1;
        
        synPatch = reshape(centroids(:,idx(1)),[patchSize,patchSize]);
        synImg(yy:yy+patchSize-1,xx:xx+patchSize-1) = reshape(synPatch,[patchSize,patchSize]);
        
%         t2 = t2 + toc; %% time recording
        
        cc = cc + 1;
        if mod(cc,500) == 0
            fprintf('*');
        end
    end
end

toc;
fprintf('\n');
idx = (denImg < 0);
denImg(idx) = 0;
denImg = denImg ./ cntMat;
cnt = sum(denImg(:));

% fprintf('t1 > %f s, t2 > %f s\n', t1, t2); %% time recording

end

