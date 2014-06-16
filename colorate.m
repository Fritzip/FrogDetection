function colorate(isitornot)
    figHandles = findobj('Type','figure');
    if isitornot==1
        col = [198/255 227/255 163/255];   % RGB Color accept
    elseif isitornot==2
        col = [227/255 223/255 163/255];  % RGB Color not sure
    elseif isitornot==0
        col = [227/255 163/255 163/255];  % RGB Color refuse
    end
    set(figHandles, 'Color',col);
end