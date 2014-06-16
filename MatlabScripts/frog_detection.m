function output = frog_detection(n_, NREDUC_, LOW_, HIGH_, NBPEAKS_, PKSEP_, PKSAMEW_, WINDET_, PLOT_, files_)

    h = waitbar(0,'Initalization …');

    % Globals
    global fs n nbech

    % Constants
    n = n_;                       %Length of FFT
    NREDUC = NREDUC_;             %Size of the reduction
    LOW = LOW_;                   %Bandpass lower bound
    HIGH = HIGH_;                 %Bandpass higher bound
    NBPEAKS = NBPEAKS_;           %Number of peaks in a signal
    PKSEP = PKSEP_;
    PKSAMEW = PKSAMEW_;
    WINDET = WINDET_;
    PLOT = PLOT_;
    FIRST = 1;

    % Variables
    files = files_;
    
    % References
    [frefp, wrefp, frefm, wrefm] = ref(NREDUC,0);
    [Pdim, Fdim, Tdim] = refxcorr;
    
    output = cell(length(files),3);
    
    for i = 1:length(files)
        if  ~ishandle(h)
            break
        end
        % Read .wav
        [w,fs] = audioread(files{i});
        splitfile = strsplit(files{i},'\');
        filename = splitfile{end};

        % Stereo to Mono
        w = stereo2mono(w);

        % Signal parameters
        nbech = length(w);
        t = (1/fs)*(1:nbech);
        
        % Half length
        halfLenPkSep = floor((PKSEP*fs)/(2*1000));    %Peak Separation detection 
        halfLenWinSame = floor((PKSAMEW*fs)/(2*1000));%Size of window in which 2 peaks are considered 'same' after & before bandpass
        halfLenWinSize = floor((WINDET*fs)/(2*1000)); %Size of window of detection
        dec = floor((100*fs)/(1000));
        THRESH = getthresh(w);
        if THRESH < 0.02
            THRESH = 0.02;
        end
            
%-------------------------------------------------------------------------
%       Find peaks separated by 2*halfl on raw and bandpass signal
%       then finds differences
%-------------------------------------------------------------------------
        waitbar(getvalue(h),h,sprintf('Finding peaks on raw and bandpass signal\n and computing differences'))

        [pks, locs, ~] = getpeakseparated(w,halfLenPkSep,NBPEAKS,THRESH);

        wbp = bandpass(w, LOW, HIGH);

        [pksbp, locsbp, overbp] = getpeakseparated(wbp,halfLenPkSep,NBPEAKS,THRESH);

        same = sort([100*intersect(floor(locs/100),floor(locsbp/100)); 100*intersect(ceil(locs/100),floor(locsbp/100)); 100*intersect(floor(locs/100),ceil(locsbp/100))]);
        diff = [];
        for loc = same'
            inf = loc - halfLenWinSame;
            sup = loc + halfLenWinSame;

            if inf < 1; inf = 1; end
            if sup > length(w); sup = length(w); end

            wmax = max(w(inf:sup));
            wbpmax = max(wbp(inf:sup));

            diff = [diff; inf sup (wmax-wbpmax)*100/wmax wmax wbpmax];
            diff = unique(diff,'rows'); % bof
        end


%-------------------------------------------------------------------------
%         FFT for all peaks found with a window of halfl
%------------------------------------------------------------------------- 
        % X-corr 2D
%         

%         [~,Fw,Tw,Pw] = dospectro(w,95);
%         varargout{3} = Pw;
%         varargout{4} = Tw;
%         varargout{5} = Fw;
%         Pw2 = imresize(Pw, [300 5540]);
%         Fw2 = imresize(Fw, [300 1]);
%         Tw2 = imresize(Tw, [1 5540]);
%         figure; surf(Tw2,Fw2,10*log10(abs(Pw2)),'edgecolor','none'); axis tight; view(0,90);
%         
        GPR = 0;
        %scores = cell(length(locsbp),7);
        scores = zeros(length(locsbp),7);
        scores(:,7) = overbp;
        %scores = {scores};
        classif = cell(length(locsbp),4);
        %classif = zeros(length(locsbp),4);
        
        set(h,'Name',filename);

        for j = 1:length(locsbp)
            msg = [num2str(j) '/' num2str(length(locsbp))];
            waitbar(getvalue(h)+1/(length(locsbp)*length(files)),h,sprintf('Scoring peaks found : %s', msg))

            inf = locsbp(j) - halfLenWinSize - dec;
            sup = locsbp(j) + halfLenWinSize - dec;

            if inf < 1; inf = 1; end
            if sup > length(wbp); sup = length(wbp); end

            % Does locsbp peaks was already in locs ? 
            indicelocbpinsame = [find(same==floor(locsbp(j)/100)*100); find(same==ceil(locsbp(j)/100)*100)]; 
            if length(indicelocbpinsame)>1
               indicelocbpinsame = indicelocbpinsame(1); % bof bof
            end

            if ~isempty(indicelocbpinsame)
                indiceloc = [find(floor(locs/100)*100==same(indicelocbpinsame)) find(ceil(locs/100)*100==same(indicelocbpinsame))];  
                indiceloc = indiceloc(1); % bof bof bof
                GPR = 1;

                indice = find((diff(:,1)<=locsbp(j)),1,'last');
                sc_dim = diff(indice,3);
            else
                sc_dim = 0;
            end

            % Do FFT on raw signal
            [~, wfftar] = dofft(w(inf:sup-1));
            ffftr = getffft(wfftar);

            % Do FFT on bandpassed signal
            [~, wffta] = dofft(wbp(inf:sup-1));
            ffft = getffft(wffta);

            % Peaks on FFT
            [fftpks, fftlocs, ~] = getpeakseparated(wfftar,200,4);

            % Do Spectro of peak windows
            [~, F, T, P] = dospectro(w(inf:sup-1),95);
            T = T+(inf/fs);
            
            % Do and plot 1D cross-correlation with ref
            [fr, wr] = reducesize(ffftr, wfftar, NREDUC);
            [c, lag] = xcorr(wr,wrefm);
            [C, I] = max(c);
            sc_xc = C/(1+abs(lag(I)));
            lagi = lag(I);

            % Scoring
            meansqr = sum((wr-wrefm).^2);
            filt = designfilter(LOW, HIGH);
            [~, wfftaprob] = dofft(filt.Numerator);
            %ffftprob = getffft(wfftaprob);
            ind = floor(fftlocs*length(filt.Numerator)/fs);
            if isequal(ind,0)
                ind = ind+1;
            end
            sc_pks = sum((fftlocs*length(filt.Numerator)/fs.*fftpks.^2).*wfftaprob(ind)');
            glob = sc_xc*sc_pks/(meansqr*(sc_dim+1));
            scores(j,1:6) = [sc_dim sc_xc lagi meansqr sc_pks glob];
            classif(j,:) = {F T P -1};
            
            if PLOT
                if FIRST
                    FIRST = 0;
                    % Plot raw signal
                    figure(1); subplot(234), plot(w), title('Raw signal'), hold on
                    plot(locs, pks, '*r'), hold off

                    % Plot bandpass signal
                    subplot(231), plot(wbp), title('Bandpass signal'), hold on
                    plot(locsbp, pksbp, '*r'), hold off
                end
                % Current peak in green
                subplot(231), hold on, plot(locsbp(j), pksbp(j), '*g'), hold off

                if GPR
                    % Fat Pink Point 
                    subplot(231), hold on, plot(locsbp(j), pksbp(j), '.m', 'MarkerSize', 20), hold off
                    subplot(234), hold on, plot(locs(indiceloc), pks(indiceloc), '.m', 'MarkerSize', 20), hold off
                end

                % Plot FFT (and peaks)
                subplot(232), plot(ffftr, wfftar, 'g'), hold on
                plotfft(ffft, wffta), hold on
                plot(fftlocs*fs/(sup-inf), fftpks, '*r'), hold off

                % Spectro
                subplot(233), surf(T,F,10*log10(P),'edgecolor','none'); axis tight; view(0,90);

                % X-correlation
                subplot(235), plot(lag, c)

                % Compare to References
                subplot(236), plot(fr, wr/max(wr), 'g'), xlim([0 10000]), hold on, 
                plot(frefm, wrefm/max(wrefm),'r'), hold off

                % Pause
                waitforbuttonpress; 

                if GPR
                    % ~Fat Pink Point
                    GPR = 0;
                    subplot(231), hold on, plot(locsbp(j), pksbp(j), '.w', 'MarkerSize', 20), hold off
                    subplot(234), hold on, plot(locs(indiceloc), pks(indiceloc), '.w', 'MarkerSize', 20), hold off
                end

                % Peaks done in blue
                subplot(231), hold on, plot(locsbp(j), pksbp(j), '*b'), hold off
            end
            if ~ishandle(h)
                break
            end
        end
%         disp(mean(cell2mat(scores(:,2))))
%         disp(mean(cell2mat(scores(:,4))))
%         disp(mean(cell2mat(scores(:,5))))
        [classif] = isitornot(scores, classif);
        output(i,:) = {filename scores classif};
    end
    close(h)
end