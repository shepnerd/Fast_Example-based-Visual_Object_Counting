function [ features, images, gtDensities, mask] = createQuickAccess( fileName, dataset, totalNum )
% try to load the quick accessible file based on the data in dataset
% if not, build it based on the data.

mask = [];
if strcmp(dataset,'cell')
    if exist(fileName,'file')
        disp('Loading features...');
        load(fileName,'features','images','gtDensities');
    else
        for i = 1 : totalNum
            disp(['Processing image #' num2str(i) ' (out of ' ...
                num2str(totalNum) ')...']);
            im = imread([dataset '/' num2str(i,'%03d') 'cell.png']);
            im = im(:,:,3);
            images{i} = im;

            % First-order and Second-order Gradient features
            disp(['Extracting gradient feature...']);
            features{i} = extr_lIm_fea(im2single(im));

            % computig ground truth densities
            gtDensities{i} = imread([dataset '/' num2str(i,'%03d') 'dots.png']);
            gtDensities{i} = double(gtDensities{i}(:,:,1))/255;

            gtDensities{i} = imfilter(gtDensities{i}, fspecial('gaussian', ...
                4.0 * 6, 4.0));
            disp(['------']);
        end
        save(fileName,'features','images','gtDensities','mask');
    end
else
    if strcmp(dataset,'mall')
        if exist(fileName, 'file')
            disp(['Loading features ...']);
            load(fileName, 'features', 'images', 'gtDensities', 'mask');
        else
            load([dataset '/mall_den.mat'],'rawden');
            load([dataset '/mall_foreground.mat']);
            load([dataset '/perspective_roi.mat']);
            
            mask = roi.mask;
            mask = imresize(mask, 1/4);
            
            gtDensities = rawden;
            images = scenes;
            for i = 1 : length(scenes)
                disp(['Processing image #' num2str(i) ' (out of ' ...
                    num2str(length(scenes)) ')...']);

                features{i} = extr_lIm_fea(im2single(images{i}));
            end
            save(fileName, 'features', 'images', 'gtDensities','mask');
        end
        
    else % dataset is ucsd
        if exist(fileName, 'file')
            disp(['Loading features ...']);
            load(fileName, 'features', 'images', 'gtDensities', 'mask');
        else
            load([dataset '/uscsd-mask.mat'],'mask');
            load([dataset '/uscsd-revised-density-gaussian.mat'],'gtDensities');
            load([dataset '/uscsd_foreground_halfsize.mat'],'scenes');

            images = scenes;
            for i = 1 : length(scenes)
                disp(['Processing image #' num2str(i) ' (out of ' ...
                    num2str(length(scenes)) ')...']);

                features{i} = extr_lIm_fea(im2single(images{i}));
            end
            save(fileName, 'features', 'images', 'gtDensities','mask');
        end
    end
end


end

