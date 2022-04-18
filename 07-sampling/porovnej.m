% Tomas Furst
% srovnani Gibbs and naive sampler
% vse na nasi vyukove PGM siti

Nreject = 1e6; % rozsah samplu
Ngibbs = 1e6;
M = 100; % tolikrat to pustim

vals = zeros(M,2); %alokace na [reject gibbs]

for i=1:1:M
    
    vals(i,1) = fpgm_reject(Nreject);
    vals(i,2) = fpgm_gibbs(Ngibbs);
    disp(['Iterace = ' num2str(i)])
    
end

mmin = min(vals(:));
mmax = max(vals(:));
bins = linspace(mmin,mmax,20);


figure(1)
histik = hist(vals(:,1),bins);
bar(bins,histik,'b')
xlabel('value')
ylabel('count')
title(['rejection sampling, N = ' num2str(Nreject) ', M = ' num2str(M)] )

figure(2)
histik = hist(vals(:,2),bins);
bar(bins,histik,'b')
xlabel('value')
ylabel('count')
title(['gibbs sampling, N = ' num2str(Ngibbs) ', M = ' num2str(M)] )


