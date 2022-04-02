% Simulation of Bayesian update for linear regression
% Tomas Furst according to Chris Bishop
% subroutine for 'updates'

% a much less naive implementation

function [W0 W1 Z] = inicialisace_updates1(sigma)

% sigma is the variance matrix for mean=0 gaussian prior

ww0 = -1:.01:1;
ww1 = -1:.01:1; % sampling of the two parameter axes
[W0 W1] = meshgrid(ww0,ww1); 

points = [W0(:), W1(:)];
mu = [0,0];
vals = mvnpdf(points,mu,sigma);
Z = reshape(vals,size(W0));