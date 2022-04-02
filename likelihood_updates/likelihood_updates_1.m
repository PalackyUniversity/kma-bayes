% Simulation of Bayesian update for linear regression
% Tomas Furst according to Chris Bishop
% subroutine for 'updates'


function  [W0 W1 L] = likelihood_updates(x,t,beta)

% [x,t] is a data point
% beta is the precission

ww0 = -1:.01:1;
ww1 = -1:.01:1; % sampling of the two axes
pred = sqrt(beta)/sqrt(2*pi);

[W0 W1] = meshgrid(ww0,ww1); 

L = nan(size(W0));
for i=1:1:length(ww0)
    for j=1:1:length(ww1)
        
        w0 = W0(i,j);
        w1 = W1(i,j); % here I stand
        mu = w0 + w1*x;
        pom = (beta/2)*(t - mu)^2; 
        
        L(i,j) = pred*exp(-pom); % explicit gaussian
        
    end
end



