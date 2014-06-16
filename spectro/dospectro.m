function [S,F,T,P] = dospectro(w,ovlp)
    global fs n
    %specgram(w,n,fs)
    [S,F,T,P] = spectrogram(w,blackman(n),floor(n*ovlp/100),n,fs,'yaxis');
end