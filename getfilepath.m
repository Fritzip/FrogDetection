function filepath = getfilepath(numfolder,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage : getfilepath(numfolder, [numbox], filename)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if size(varargin,2)==1
        foldpath = getpath(numfolder);
        filename = varargin{1};
    elseif size(varargin,2) == 2
        foldpath = getpath(numfolder,varargin{1});
        filename = varargin{2};
    else
        error('(Not enough / Too much) arguments')
    end
    
    filepath = strcat(foldpath,filename);
end