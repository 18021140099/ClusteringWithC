function plotClustering(dataset, labels, classes, centroids)
% plots the result of a clustering algorithm, using for points
% in dataset different colors (according to the assigned labels)
% and different shapes (according to thei ground-truth classes)

SYM = {'+','x','s','o','.','*','d','v','^','<','>','p','h'};
cm = colormap(jet);

[z,z,ll] = unique(labels);
[z,z,cc] = unique(classes);

hold on
for k = 1:length(classes)
    if size(dataset,2)==2
        h=plot(dataset(k,1),dataset(k,2),SYM{cc(k)},'markersize',8); 
    elseif size(dataset,2)==3
        h=plot3(dataset(k,1),dataset(k,2),dataset(k,3),SYM{cc(k)},'markersize',8);          
    end
    set(h,'Color',cm(round(ll(k)/length(unique(ll))*64),:)); 
end

if nargin==4
	if size(dataset,2)==2
		plot(centroids(:,1),centroids(:,2),'kx','LineWidth',2);
	elseif size(dataset,2)==3
		plot3(centroids(:,1),centroids(:,2),centroids(:,3),'kx','LineWidth',2);
	end
end	
hold off
caxis([1 length(unique(ll))])
axis image
axis off
end
