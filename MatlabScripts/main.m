clear all; clc; close all;

% Launcher - get algorithm parameters, mode and files
[n_, NREDUC_, LOW_, HIGH_, NBPEAKS_, PKSEP_, PKSAMEW_, WINDET_, PLOT_, PLAIN_, CHECK_, files_, LAUNCH_] = launcher;

if LAUNCH_
    % Launch frog detection algorithm
    output = frog_detection(n_, NREDUC_, LOW_, HIGH_, NBPEAKS_, PKSEP_, PKSAMEW_, WINDET_, PLOT_, files_);
      
    for i = 1:size(output,1)
        filename = output{i,1};
        scores = output{i,2};
        classif = output{i,3};
        algores = cell2mat(classif(:,4));
        
        indice = find(scores(:,7)==0,1,'first');
        
        if ~isempty(indice)
            if isequal(indice,1)
                scores = [];
                classif = [];
                algores =[];
            elseif indice>1
                scores = scores(1:indice,:);
                classif = classif(1:indice,:);
                algores = algores(1:indice,:);
            end
        end
        
        sprintf('%d frog calls detected on %s',sum(algores), filename)
        if CHECK_ && ~isempty(scores) && ~isempty(classif)
            % Check Results GUI12
            userres = check_results(classif, scores, filename);

            % Evaluate
            userres = userres';
            algores = algores(1:length(userres));

            TP = 100*length(intersect(find(algores==1),find(userres==1)))/length(userres);
            TN = 100*length(intersect(find(algores==0),find(userres==0)))/length(userres);
            FP = 100*length(intersect(find(algores==1),find(userres==0)))/length(userres);
            FN = 100*length(intersect(find(algores==0),find(userres==1)))/length(userres);
            sprintf('TP = %3.0f\nTN = %3.0f\nFP = %3.0f\nFN = %3.0f\n',TP,TN,FP,FN)
            
        end
    end
end