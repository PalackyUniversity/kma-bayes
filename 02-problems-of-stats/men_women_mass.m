% Tomas Furst pro Bayes4DataScience

mu_men =  83.6; % podle lidovek
mu_women = 69.2;
std_men = 20;
std_women = 20; % jsem si vymyslel
N = 100;

men = normrnd(mu_men,std_men,1,N);
women = normrnd(mu_women,std_women,1,N);

bins = 20:5:150;
hist_men = hist(men,bins);
hist_women = hist(women,bins);
figure(1)
bar(bins,hist_men,'b')
figure(2)
bar(bins,hist_women,'r')

[h,p] = ttest2(men,women);