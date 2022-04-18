% Tomas Furst for Summer school in Ostrava
% Correct, i.e. Bayesian inference

% Two independednt tests T1 and T2 for a disease D
% What does independence mean??
prev = 0.001; % prevalence of D
sens1 = 0.99; % sensitivity of T1: prob(T1+ | D+)
spec1 = 0.99; % specificity of T1: prob(T1- | D-)
sens2 = 0.99; % sensitivity of T2: prob(T2+ | D+)
spec2 = 0.99; % specificity of T2: prob(T2- | D-)

% The question: What is the prob(D+ | T1+,T2+)??

N = 1e6; % number of simulations
state = false(N,3); % allocation for [D T]
% i.e. state(2,:) = [0 1 0] means that in the second simulation, 
% the person did not have the disease, T1 came out positive and T2 negative

%% the simulation (back to naive version)

tic
for i=1:1:N
    
    pom = rand; % random number with uniform distribution on [0 1]
    D = pom<prev; % D=1 with prob = prev

    if D % if the person has the disease
        T1 = rand < sens1; 
        T2 = rand < sens2; 
    else % the person does not have the disease
        T1 = rand < (1-spec1); 
        T2 = rand < (1-spec2); 
    end
    state(i,:) = [D T1 T2];
end
toc

%% inference

kde = state(:,2)==1 & state(:,3)==1; % both tests positive
pom = sum(state(kde,1))/sum(kde);
disp(['Simulated p(D+ | T1+, T2+) = ' num2str(pom)])

