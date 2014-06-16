function avboxes = getavailableboxes
    boxes = {'BOX01\', 'BOX02\', 'BOX03\', 'Box04\'};
    avboxes = [];
    for i = 1:length(boxes)
        if exist([getpath(3) boxes{i}]) 
            avboxes = [avboxes i];
        end
    end
end