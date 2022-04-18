% Tomas Furst for Summer school in Ostrava
% Correct, i.e. Bayesian inference

% A less naive implementation: avoid for cycles if you can
% a subroutine of ostrava1.m

function argout = ostrava3(argin)

% argout is the simulated prob(D+ | T+)
% argin = [N prev sens spec]

N = argin(1); % number of simulations
prev = argin(2); 
sens = argin(3);
spec = argin(4);

T = false(N,1); % allocation for the state of T

pom = rand(N,1); % vector of N iid uniform [0 1] numbers
%%% runif(N)
D = pom<prev; % state of D

pom = rand(N,1); % another iid vector
indik = pom<sens; % with this prob the D+ will be T+
T(D==1)=indik(D==1);

pom = rand(N,1); % another iid vector
indik = pom>spec; % with this prob the D- will be T+
T(D==0)=indik(D==0);

argout = sum(D(T==1))/sum(T==1);
