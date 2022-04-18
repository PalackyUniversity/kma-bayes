% Tomas Furst for Summer school in Ostrava
% Correct, i.e. Bayesian inference

% A naive implementation of the simulation
% a subroutine of ostrava1.m

function argout = ostrava2(argin)
%%% ostrava2 = function(argin) {telo fce .... return(argout)}

% argout is the simulated prob(D+ | T+)
% argin = [N prev sens spec]

N = argin(1); % number of simulations
prev = argin(2); 
sens = argin(3);
spec = argin(4);

state = false(N,2); % allocation for [D T]

for i=1:1:N
    
    pom = rand; % random number with uniform distribution on [0 1]
    D = pom<prev; % D=1 with prob = prev
    state(i,1) = D; % save the disease state
    if D % if the person has the disease
        T = rand < sens; % T=1 with prob = sens
    else % the person does not have the disease
        T = rand < (1-spec); % T=1 with prob = (1-spec)
    end
    state(i,2)=T;
end

kde = state(:,2)==1; % tested positive
argout = sum(state(kde,1))/sum(kde);
