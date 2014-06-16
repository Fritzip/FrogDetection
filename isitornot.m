function classif = isitornot(scores, classif)
    % Normalize score
    scoresnorm = scores;
    if ~isempty(scoresnorm)
        scoresnorm(:,2) = (scoresnorm(:,2)-mean(scoresnorm(:,2)))/std(scoresnorm(:,2));
        scoresnorm(:,4) = (scoresnorm(:,4)-mean(scoresnorm(:,4)))/std(scoresnorm(:,4));
        scoresnorm(:,5) = (scoresnorm(:,5)-mean(scoresnorm(:,5)))/std(scoresnorm(:,5));
        %format shortG
        %disp(scoresnorm)

        % Signs
        scoresign = scoresnorm;
        scoresign(:,2) = sign(scoresign(:,2));
        scoresign(:,4) = sign(scoresign(:,4)).*-1;
        scoresign(:,5) = sign(scoresign(:,5));
        scoresign3sup = (abs(scoresign(:,3))>3)*-1;
        scoresign3inf = abs(scoresign(:,3))<3;
        scoresign(:,3) = scoresign3sup+scoresign3inf;
        scoresign1sup = (scoresign(:,1)>15)*-1;
        scoresign1inf = (scoresign(:,1)<0)*2;
        scoresign1betw = (scoresign(:,1)<15).*(scoresign(:,1)>0);
        scoresign(:,1) = scoresign1sup+scoresign1inf+scoresign1betw;
        scoresign(:,6) = sum(scoresign(:,1:5),2);

        for i = 1:size(classif,1)
            classif(i,4) = {scoresign(i,6)>0};
        end
    end
    
    %format shortG
    %disp(scoresign)
end