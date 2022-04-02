% Simulation of Bayesian update for linear regression
% Tomas Furst according to Chris Bishop
% subroutine for 'updates'

% a less naive implementation: vectorized

function  [W0 W1 L] = likelihood_updates1(x,t,beta)

% [x,t] is a data point
% beta is the precission

ww0 = -1:.01:1;
ww1 = -1:.01:1; % sampling of the two axes
[W0 W1] = meshgrid(ww0,ww1); 
pred = sqrt(beta)/sqrt(2*pi);

points = [W0(:), W1(:)];
mu = points(:,1) + x*points(:,2);
te = t*ones(size(mu));
pom = (beta/2)*(te - mu).^2; 
L = pred*exp(-pom); % explicit gaussian
L = reshape(L,size(W0));


