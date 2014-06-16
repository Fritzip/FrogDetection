function [frefp, wrefp, frefm, wrefm] = ref(n,PLOT)
    
    global fs
    
    %--------------------------------------------------------------------------
    %       Pinchoni
    %--------------------------------------------------------------------------
    [w, fs] = audioread(getfilepath(3,3,'BOX03_20130518_002831.wav'));
    w = stereo2mono(w);
    
    % Handles def
    bt = @(t) floor(t*fs);
    
    % Manual selection of Pichoni calls
    bn = [28.47  36.70;
        37.7    47.14;];

    bn = bt(bn);
    wp = [];
    
    for i = 1:length(bn)
        wp = [wp; w(bn(i,1):bn(i,2))];
    end

    % Do FFT 
    [~, wffta] = dofft(wp);
    ffft = (0:length(wffta)-1)*(fs/(2*(length(wffta)-1)));

    % Envelope of size n
    [frefp, wrefp] = reducesize(ffft, wffta, n);

    % Plot envelope and spectrum normalized
    if PLOT
        plot(frefp, wrefp/max(wrefp),'r'), hold on
        plotfft(ffft, wffta/max(wffta)), hold off
    end

    % Other method for getting envelope
    % [fftpks fftlocs] = getpeakseparated(wffta,400,200,'none');
    % plot(fftlocs*fs/(2*(length(wffta)-1)), fftpks, 'r')

    %--------------------------------------------------------------------------
    %       Martini
    %--------------------------------------------------------------------------
    [w, fs] = wavread(getfilepath(3,3,'BOX03_20130518_214910.wav'));
    w = stereo2mono(w);


    % Manual selection of Martini calls
    bn = [5.26  8.71;
        9.05    12.35;
        12.70   14.16;
        14.5    15.71;
        16.02   16.98;
        17.35   18.41;
        20.06   21.16];

    bn = bt(bn);
    wm = [];
    for i = 1:length(bn)
        wm = [wm; w(bn(i,1):bn(i,2))];
    end


    % Do FFT 
    [~, wffta] = dofft(wm);
    ffft = getffft(wffta);

    % Envelope of size n
    [frefm, wrefm] = reducesize(ffft, wffta, n);

    % Plot envelope and spectrum normalized
    if PLOT
        plot(frefm, wrefm/max(wrefm),'r'), hold on
        plotfft(ffft, wffta/max(wffta)), hold off
    end
end

% Other method for getting envelope
% [fftpks fftlocs] = getpeakseparated(wffta,400,3000,'none');
% loc2f = fs/(2*(length(wffta)-1));
% plot(fftlocs*loc2f, fftpks, 'r')

