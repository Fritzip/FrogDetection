function wout = denoise(win,varargin)
%     wout = win.*abs(win)/max(abs(win));
    
    thresh = -50;
    reduc = 90;
    if size(varargin,2)>0
        thresh = varargin{1};
    elseif size(varargin,2)>1
        reduc = varargin{2};
    end
    wout = sign(win).*db2mag(mag2db(abs(win))-((mag2db(abs(win)))<thresh).*reduc);
end