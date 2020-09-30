function kMedoidsDemo(dataset)

% ------------------------ parameters section -------------------------------
if nargin<1
	dataset = './data/noisyBlobs01'; % also try noisyBlobs02 and noisyBlobs03
end

interactive = 1;

% ------------------------ here be the code ---------------------------------
% load dataset - also try with other .mat files (e.g. circles02.mat, ...)
load(dataset);

clc
fprintf('I have loaded dataset %s\n',dataset);
fprintf('Dataset characteristics: %d points, %d-dimensional space, %d clusters\n\n',size(X,1),size(X,2),clusters);
% plot data
fprintf('Plotting data...\n');
figure;plotClustering(X,classes,classes);drawnow();
title('Data plot (colors/shapes represent different classes)')
fprintf('What you have just seen is (slightly) noisy dataset. Each color/shape matches\n');
fprintf('a different cluster. Let us see how kMeans is able to deal with these data...\n\n');
if (interactive) fprintf('Press a key to continue.\n\n'); pause; end

% k-means
fprintf('Running kMeans...\n');
[labels,centroids] = clusterKM(X,clusters);
%[centroids,~,labels] = myKmeans(X,clusters);
figure;plotClustering(X,labels,classes,centroids);drawnow();
title(sprintf('Results of k-means (k=%d) ran on the original data space. Accuracy: %.4f',clusters,accuracy(labels,classes)));
fprintf('If you were lucky enough (initialization is random!) kMeans performed pretty\n');
fprintf('well (accuracy=~94%%) on this dataset. Otherwise you can clearly see that noise\n');
fprintf('is able to affect the clustering algorithm, making results much worse.\n\n');
if (interactive) fprintf('Press a key to continue.\n\n'); pause; end

fprintf('Running kMedoids...\n');
[medoidsIDX,labels,~]=kMedoids(X,clusters);
% Retrieve the coordinates of medoids in cartesian space
medoids = X(medoidsIDX,:);
figure;plotClustering(X,labels,classes,medoids);drawnow();
title(sprintf('Results of k-medoids (k=%d) ran on the original data space. Accuracy: %.4f',clusters,accuracy(labels,classes)));
fprintf('As you can see, kMedoids performed better on this dataset. Can you explain why?\n\n');

end
