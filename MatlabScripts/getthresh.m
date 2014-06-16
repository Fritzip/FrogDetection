function thresh2 = getthresh(w)
    global nbech
    
    wd = sort(abs(w),'descend');

    % Return % of points over threshold (x)
    pcovth = @(x) sum(abs(w)>x)*100/nbech;
    
    % Return threshold in order to have x % above
    thofpc = @(x) wd(floor(x*nbech/100));

%-------------------------------------------------------------------------       
%         Derivative & plot peaks on derivative
%-------------------------------------------------------------------------
    df = diff(wd);
    df2 = (df.*abs(df)/max(abs(df))).*-1;
    [~, locs] = findpeaks(df2,'MINPEAKHEIGHT',std(df2));

%-------------------------------------------------------------------------
%         Plot thresholds founds thanks to derivative and peaks
%-------------------------------------------------------------------------

    thresh = wd(max(locs));
    thresh2 = (thresh + std(wd))/2;
    if pcovth(thresh2)>0.5
       thresh2 = thofpc(0.5); 
    end
end