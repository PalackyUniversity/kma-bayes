% Simulation of Bayesian update for linear regression
% Tomas Furst according to Chris Bishop
% subroutine for 'updates'

function argout = reject_sample_updates(W0,W1,Z,N)

% samples N points from the 2D distribution given by W0, W1, Z
% the simplest rejection sampling idea

mam = 0;
samples = nan(N,2); % allocate for [w0 w1]
[mm nn] = size(W0);
M = max(Z(:));

while mam<N % while not enough samples generated
    
    x = ceil(mm*rand);
    y = ceil(nn*rand);
    z = M*rand;
    % (x,y,z) is a random point in the box uniformly generated
    val = Z(x,y); % if it is under the pdf, accept it
    if val>z % accept
        mam = mam+1;
        samples(mam,:) = [W0(x,y) W1(x,y)];
    end
end

argout = samples;