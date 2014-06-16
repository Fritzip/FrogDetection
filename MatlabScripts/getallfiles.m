function [files, foldpath] = getallfiles(numfolder, varargin)
    if size(varargin,2)==1
        foldpath = getpath(numfolder,varargin{1});
    elseif size(varargin,2)==0
        foldpath = getpath(numfolder);
    end
    
    files = dir(strcat(foldpath,'*.wav')); 
end