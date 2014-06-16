function plotspectro(w, ovlp)
    global fs n
    %specgram(w,n,fs)
    spectrogram(w,blackman(n),floor(n*ovlp/100),n,fs,'yaxis');
    %xlim([0 60])
    %ylim([1400,4000])
end