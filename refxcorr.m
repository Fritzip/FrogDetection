function [Pdim, Fdim, T] = refxcorr()

%Globals
global fs nbech n

%--------------------------------------------------------------------------
%       Martini Forest Playback -- Patern recognition model
%--------------------------------------------------------------------------
%Read file
[w, fs] = audioread(getfilepath(2,'martiniForetx10.wav'));
w = stereo2mono(w);

%Script Parameters
nbech = length(w);
t = (1/fs)*(1:nbech); 
n = 1024;

%Handles def
bt = @(t) floor(t*fs);

%Manip
bn = [1.11  1.60];
bn = bt(bn);

wm = w(bn(1):bn(2));
wm = wm(find(abs(wm)>0,1)-n+600:end);
wm = flipud(wm);
wm = wm(find(abs(wm)>0,1)-n+600:end);
wm = flipud(wm);

[~, wffta] = dofft(wm);
ffft = getffft(wffta);

[~, F, T, P] = dospectro(wm,95);

supf = find(F>4200,1);
inff = find(F<1300,1,'last');
Fdim = F(inff:supf);
Pdim = P(inff:supf,:);

% Pdim2 = imresize(Pdim, [20 20]);
% Fdim2 = imresize(Fdim, [20 1]);
% Tdim2 = imresize(T, [1 20]);

% 
% figure
% surf(T,Fdim,10*log10(Pdim),'edgecolor','none'); axis tight; view(0,90); colorbar
% figure
% surf(Tdim2,Fdim2,10*log10(abs(Pdim2)),'edgecolor','none'); axis tight; view(0,90); colorbar

