% prokleti dimenze
% Tomas Furst

%% kvadrat normalne rozdelene veliciny v 1D

N = 10000; % tolik bodu
x = randn(N,1); % x = Norm(0,1) v dim=1
y = sqrt(x.^2); % vzdalenost od pocatku

bins = 0:.1:7;
histik = hist(y,bins);
bar(bins,histik)


%% kvadrat normalne rozdelene veliciny v nD

close all

D = 500; % tohle je ted dimenze
x = randn(N,D); % x = Norm(0,1) v dim=D
pom = x.^2;
y = sqrt(sum(pom,2)); % tedy y = ||x||^2

od = D - 3*sqrt(2*D);
do = D + 3*sqrt(2*D);
% bins = linspace(od,do,100);
% histik = hist(y,bins);
% figure
% bar(bins,histik)

figure
%bins = linspace(0,sqrt(do),100);
bins = linspace(0,50,100);
histik = hist(y,bins);
bar(bins,histik)
axis([0 50 0 max(histik)])

%% typicke vahy u importance sampling

bodu = 100; % tolik bodu chci vybrat
D = 200; % dimenze problemu
R = 1; % polomer koule na niz mam uniform distribution
sigma = R/(2*sqrt(D)); % podmink sqrt(D) sigma < R

mu = zeros(1,D);
pom = sigma^2*ones(1,D);
SIGMA = diag(pom);
x = mvnrnd(mu,SIGMA,bodu); % sample
qx = mvnpdf(x,mu,SIGMA);
w = 1./qx;






