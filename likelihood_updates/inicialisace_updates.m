% Simulation of Bayesian update for linear regression
% Tomas Furst according to Chris Bishop
% subroutine for 'updates'

function [W0 W1 Z] = inicialisace_updates(sigma)

% sigma is the variance matrix for mean=0 gaussian prior

ww0 = -1:.01:1;
ww1 = -1:.01:1; % sampling of the two parameter axes

[W0 W1] = meshgrid(ww0,ww1); 
pom1 = 1/(2*pi);
pom2 = 1/sqrt(det(sigma)); % =alfa:)
invs = inv(sigma); % invers variancni matice
Z = nan(size(W0));
for i=1:1:length(ww0)
    for j=1:1:length(ww1)
        
        x = W0(i,j);
        y = W1(i,j); % here I stand
        vek = [x; y]; % mean=0, nothing subtracted
        pom3 = vek'*(invs*vek);
        Z(i,j) = pom1*pom2*exp(-0.5*pom3);
        
    end
end