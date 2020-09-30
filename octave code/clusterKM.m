function [idx,ctrs] = clusterKM(x,C)

N = size(x,1);
idx_old = zeros(N,1);
d = zeros(N,C);

% Centroids random initialization
p = randperm(N);
ctrs = x(p(1:C),:);

iter = 1;
while iter <= 100
    % Compute distances between points and centroids
    for i = 1:N
        for j = 1:C
           d(i,j) = norm(x(i,:) - ctrs(j,:)); 
        end
    end
    
    % Find new labels (belonging clusters)
    [m,idx] = min(d,[],2);
    % Compare new labels to the old ones
    if all(idx == idx_old)
        return  % Nothing has changed. We are done
    else
        idx_old = idx;  % Update labels
    end
    
    % Compute new centroids
    for i = 1:C
        x_i = x(idx == i,:);
        
        if ~isempty(x_i)
            ctrs(i,:) = mean(x_i);
        end
    end
    
    iter = iter + 1;
end

display('Warning: failed to converge after 100 iterations')