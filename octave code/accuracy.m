function [a] = accuracy(labels,classes)
% calculates accuracy as the percentage of right matches/mismatches
% wrt ground truth
% NOTE: wrt micro-averaged accuracy, values tend to be much higher
%       (closer to 1) 
    corra = 0;
    tota = 0;

    idxLen = length(labels);

    for i = 1 : idxLen-1
        for j = i+1 : idxLen
            % accuracy
            if (labels(i)==labels(j) && classes(i)==classes(j)) || (labels(i)~=labels(j) && classes(i)~=classes(j))
                corra = corra + 1;
            end
            tota = tota + 1;
        end
    end

    a = corra/tota;
end
