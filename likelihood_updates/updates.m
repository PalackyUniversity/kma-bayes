% Simulation of Bayesian update for linear regression
% Tomas Furst according to Chris Bishop
% main file

% single input variable x
% single output variable t
% linear model y(x,w) = w0 + w1*x   nejjednodussi linearni regrese R \to R
% synthetic data generated from f(x) = -0.3 + 0.5*x + Norm(0,0.2)
skut = [-0.3 0.5]; % real parameters
% we want to illustrate how [w0 w1] approach 'skut' as we get more data
% beta = 1/(0.2)^2 = 25 is assumed known
beta = 25;
% alfa (prior precission) = 0.2 fixed for simplicity
alfa = 0.2;

% in each iteration, we will simulate
% fig1 and fig2: likelihood for the last point
% fig3 and fig4: prior = posterior from the last point
% fig5: N samples from the current distribution
N=10; % how many sample lines we want to see

%% Initialisation (we don't have any data yet = no likelihood, just the prior)

sigma = [1/alfa 0; 0 1/alfa]; % variance matrix for the prior
% [W0 W1 Z] = inicialisace_updates(sigma); % generate prior distribution
% W0, W1 and Z in the form of matlab meshgrid matrices
% less naive implementation 
[W0 W1 Z] = inicialisace_updates1(sigma); % 25 times faster:)


figure(1)
hold off
title('Likelihood')

figure(3)
hold off
contour(W0,W1,Z)
hold on
plot(skut(1),skut(2),'k*')
xlabel('w0')
ylabel('w1')
title('Prior')

% figure(4)
% mesh(W0,W1,Z)
% title('Prior Density')

% Draw from the prior
%bsamples = reject_sample_updates(W0,W1,Z,N);
% less naive implementation is here:
MU = zeros(N,2);
samples = mvnrnd(MU,sigma);

figure(5)
hold off
xx = -1:.01:1;
for i=1:1:N
    yy = samples(i,1) + samples(i,2).*xx;
    plot(xx,yy)
    hold on
end
axis([-1 1 -1 1])
xlabel('x')
ylabel('y')
title('Data space')

pause

%% Loop over data points
NN = 30;
body = nan(NN,2); % allocation for points generated
 
for k=1:1:NN % data points are comming
    
    x = 2*rand-1; % unif [- 1 1]
    t = skut(1) + skut(2)*x + randn/beta;
    body(k,:) = [x t];
    % [x t] is the k-th data point
    % likelihood p(t | y,w) = Norm(mu = w0 + w1*x, sigma^2 = beta^-1)
    % plot likelihood as function of w0 and w1
    % [W0 W1 L] = likelihood_updates(x,t,beta);
    [W0 W1 L] = likelihood_updates1(x,t,beta); % less naive version

    
    figure(1)
    hold off
    contour(W0,W1,L)
    hold on
    plot(skut(1),skut(2),'k*')
    xlabel('w0')
    ylabel('w1')
    title('Likelihood')
    
%     figure(2)
%     hold off
%     mesh(W0,W1,L)
%     title('Likelihood')

    Z = Z.*L; % posterior = prior x likelihood
    Z = 100*100*Z./sum(Z(:)); % a little dubious normalisation
    
    figure(3)
    hold off
    contour(W0,W1,Z)
    hold on
    plot(skut(1),skut(2),'k*')
    xlabel('w0')
    ylabel('w1')
    title(['Posterior after ' num2str(k) ' points'])

%     figure(4)
%     hold off
%     mesh(W0,W1,Z)
%     title(['Posterior after ' num2str(k) ' points'])
    
    % Draw from the posterior
    samples = reject_sample_updates(W0,W1,Z,N);
    

    figure(5)
    hold off
    xx = -1:.01:1;
    for i=1:1:N
        yy = samples(i,1) + samples(i,2).*xx;
        plot(xx,yy)
        hold on
    end
    for i=1:1:k
        plot(body(i,1),body(i,2),'r*')
    end
    axis([-1 1 -1 1])
    xlabel('x')
    ylabel('y')
    title('Data space')
   
    pause
    
end

%% analyticky posterior

mu_0 = [0;0]; % prior mean
sigma_0 = sigma; % prior var matrix
design = [ones(NN,1) body(:,1)];
pom = inv(sigma_0) + beta*design'*design; 
S_N = inv(pom); % tohle je S_N
pom = beta*design'*body(:,2);
mu_N = S_N*(inv(sigma_0)*mu_0 + pom);

% nakreslit
figure(6)
points = [W0(:), W1(:)];
vals = mvnpdf(points,mu_N',S_N);
Z = reshape(vals,size(W0));
contour(W0,W1,Z)


%% ted jeste nakreslit nejistoty

mu_0 = [0,0]; % prior mean
sigma_0 = sigma; % prior var matrix
design = [ones(NN,1) body(:,1)];

pom = alfa*eye(2) + beta*design'*design; 
sigma_N = inv(pom);
pom = beta*design'*body(:,2);
mu_N = sigma_N*pom;

% generate many new data points
xx = -1:.01:1;
lajny = nan(length(xx),3); % alokace na [dolni mean horni]

for i=1:1:length(xx)
    x = xx(i); % aktualni bod
    new_design = [1; x];
    mu_pred = mu_N'*new_design;
    sigma_pred = 1/beta + new_design'*sigma_N*new_design;
    lajny(i,:) = [mu_pred - 2*sigma_pred, mu_pred, mu_pred + 2*sigma_pred];
    
end

figure(5)
plot(xx,lajny(:,1),'k','LineWidth',2)
plot(xx,lajny(:,3),'k','LineWidth',2)
plot(xx,lajny(:,2),'m','LineWidth',2)





    
