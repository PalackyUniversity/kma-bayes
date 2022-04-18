% Tomas Furst for Summer school in Ostrava
% Correct, i.e. Bayesian inference

% Test T for a disease D
prev = 0.001; % prevalence of D
sens = 0.99; % sensitivity of the test, i.e. prob(T+ | D+)
spec = 0.99; % specificity of the test, i.e. prob(T- | D-)

% The question: What is the prob(D+ | T+)??

N = 1e6; % number of simulations
state = false(N,2); % allocation for [D T]
%%% state = matrix(ncol=2,nrow=N)
% i.e. state(2,:) = [0 1] means that in the second simulation, 
% the person did not have the disease but the test came out positive

%% the simulation

tic
for i=1:1:N
    %%% for (i in 1:N) {telo}
    
    pom = rand; % random number with uniform distribution on [0 1]
    %%% runif(1)
    D = pom<prev; % D=1 with prob = prev
    state(i,1) = D; % save the disease state
    %%% state[i,1]=D;
    if D % if the person has the disease
        T = rand < sens; % T=1 with prob = sens
    else % the person does not have the disease
        T = rand < (1-spec); % T=1 with prob = (1-spec)
    end
    state(i,2)=T;
end
toc

%% inference

pom = sum(state(:,1))/N;
%%% sum(state[,1]) % prvni sloupec
disp(['True prevalence = ' num2str(prev) ',   simulated prevalence = ' num2str(pom)])
%%% print(paste('True prevalence = ', prev, ',   simulated prevalence = ', pom))

kde = state(:,1)==1; % only diseased
pom = sum(state(kde,2))/sum(kde);
disp(['True sensitivity = ' num2str(sens) ',   simulated sensitivity = ' num2str(pom)])

kde = state(:,1)==0; % only healthy
pom = sum(state(kde,2))/sum(kde);
disp(['True (1-specificity) = ' num2str(1-spec) ',    simulated (1-specificity) = ' num2str(pom)])

kde = state(:,2)==1; % tested positive
pom = sum(state(kde,1))/sum(kde);
disp(['Simulated p(D+ | T+) = ' num2str(pom)])

%% Do you want a distribution of the result?

% See ostrava2 how not to do it
pars = [N, prev, sens, spec];
%%% nekde v tele musim mit source("filename.r")
% pod tim filename je ulozena ta externi fce
% volam ji cislo = ostrava2(argin)

tic, ostrava2(pars), toc

% See ostrava3 how to do it better
tic, ostrava3(pars), toc

% So let's see the distribution
M = 100;
vals = nan(M,1);
for i=1:1:M
    disp(i)
    vals(i) = ostrava3(pars);
end

bins = linspace(min(vals),max(vals),20);
histik = histc(vals,bins);
bar(bins,histik)
xlabel('Simulated prob(D+ | T+)')
ylabel('Counts')
%%% hist(promenna)

% You can now answer questions of the type:
% How probable is that less that more than 90% of the T+ population will be false positive?
% How probable is it that that less than 1% of T- population is false negative?
% And many more, in classical statsitics strictly forbidden questions.

%% Let's learn how to compute this precisely

% The Bayes' Theorem
% Go Bayes!


