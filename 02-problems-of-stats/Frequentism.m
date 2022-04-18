% Tomas Furst for Summer school in Ostrava
% Correct, i.e. Bayesian inference
% Summer Camp - Data Analysis with R


% nasty disease = frequentism = D

% pa = prob(contract D within a year from vaccination by A)
% pb = prob(contract D within a year from vaccination by B)


pa = 0:0.002:.5; % axis pa for visualisation
pb = 0:0.002:1;  % axis pb for visualisation
[a b] = meshgrid(pa,pb); % 2 dimensional mesh grid
pom1 = nchoosek(30,1)*a.*(1-a).^(29);
pom2 = nchoosek(10,3)*b.^3.*(1-b).^7;
post = pom1.*pom2; % explicit formula for likelihood

mesh(a,b,post); % show

% prob(A is better than B)
maska = b>a;
pom1 = maska.*post;
vysl = sum(pom1(:))/sum(post(:));
disp(['Prob(A is better than B) = ' num2str(vysl)])

% prob(B is 10 times better than A)
maska = b>10*a;
pom1 = maska.*post;
vysl = sum(pom1(:))/sum(post(:));
disp(['Prob(A is at least 10 times better than B) = ' num2str(vysl)])

