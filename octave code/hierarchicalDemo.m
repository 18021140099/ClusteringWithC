function hierarchicalDemo(dataset)

% ------------------------ parameters section -------------------------------
if nargin<1
        dataset = './data/crescents'; % also try circles, agglomerative, noisyBlobs, ...
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
fprintf('The default dataset chosen for this demo (crescents) shows two clusters\n');
fprintf('which are not globular. This is one of the weak points of k-means, let\n');
fprintf('us see how it performs...\n');
if (interactive) fprintf('Press a key to continue.\n\n'); pause; end

% k-means
fprintf('Running kMeans...\n');
[centroids,~,labels] = myKmeans(X,clusters);
figure;plotClustering(X,labels,classes,centroids);drawnow();
title(sprintf('Results of k-means (k=%d) ran on the original data space. Accuracy: %.4f',clusters,accuracy(labels,classes)));
fprintf('As expected, k-means results are pretty bad. Can you explain why\n');
fprintf('this algorithm performs so badly on non-globular data?\n');
if (interactive) fprintf('Press a key to continue.\n\n'); pause; end

% hierarchical
% NOTE: L2_distance should be faster than pdist and directly returns a matrix
%       if you want to use pdist remember to also call squareform
Y = L2_distance(X',X');
labels=hclust(Y,'single',2);
figure;plotClustering(X,labels,classes);drawnow();
title(sprintf('Results of hierarchical (k=%d) ran on the original data space. Accuracy: %.4f',clusters,accuracy(labels,classes)));


