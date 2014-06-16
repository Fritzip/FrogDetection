function [fr wr] = reducesize(ffft, wffta, size)
    windowSize = floor(length(wffta)/(size));
    w = filter(ones(1,windowSize)/windowSize,1,wffta);
    f = filter(ones(1,windowSize)/windowSize,1,ffft);
    wr = w(windowSize:windowSize:windowSize*size);
    fr = f(windowSize:windowSize:windowSize*size);
end