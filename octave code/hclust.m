function cluster = hclust(D, linkage, clusters)
	% Hierarchical clustering using 'single', 'complete', or 'average' linkage.
	% D contains distances. If clusters (number of) is specified then cluster 
        % is a vector containing the labels assigned as if hclust stopped at #clusters
	% Otherwise the rows of ’cluster’ represent all the partitions.

	[R,C] = size(D);
	for i=1:size(D,1)
		D(i,i) = Inf;
	end
	
	% Put every point is in its own cluster.
	cluster(1,:) = [1:R];
	for i=2:size(D,1)
		cluster(i,:) = cluster(i-1,:);
		% Find closest clusters
		[MR,ID] = min(D);
		[T,J] = min(MR);
		I = ID(J);
		% Swap so that I <= J.
		U = sort([I, J]);
		I = U(1);
		J = U(2);
		% Merge cluster j with cluster i, then delete cluster j.
		ii = find(cluster(i,:) == J);
		cluster(i,ii) = I;
		ii = find(cluster(i,:) > J);
		cluster(i,ii) = cluster(i,ii) - 1;
		% Calculate new distance matrix
		switch linkage
		case 'single'
			D(:,I) = min(D(:,I), D(:,J));
			D(I,:) = min(D(I,:), D(J,:));
		case 'complete'
			% complete the code here
		case 'average'
			% complete the code here
		end
		ii = setdiff([1:size(D,2)],J);
		D(I,I) = Inf;
		D = D(ii,ii);
	end	
	if nargin == 3
		cluster = cluster(end-clusters+1,:);
	end
end	
