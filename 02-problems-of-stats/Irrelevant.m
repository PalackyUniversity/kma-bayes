% Tomas Furst for Summer school in Ostrava
% Correct, i.e. Bayesian inference
# Summer Camp - Data Analysis with R

% Dependence of p-values on irrelevant information

pa = 0:0.001:1; % possible values of prob(coin lands face 'a' up)
prior = ones(size(pa)); % whatever prior you might have as a function of pa

% % prior = pa>.4 & pa<.6;
% % prior = prior./sum(prior); % normalisation
% % prior = prior*length(xx);

sequence = 'aaabaaaabaab'; % sequence obtained in experiment
% % sequence = 'aaababbabbab'; 
% pa is the prob that the coin lands face 'a' up

% Bayes: p(pa | sequence) = prob(sequence | pa) prob(pa) \ prob(sequence)
% Thus:   p(pa | sequence) is proportional to prob(sequence | pa) prob(pa)
% Likelihood: prob(sequence | pa) = pa^(# of a's) (1-pa)^(# of b's)

% Let's visualise the stream of information

figure(1)
plot(pa,prior)
%%% plot(y~x, type="l", xlim = c(0,1), ylim ,....)
xlabel('pa')
ylabel('prob')
title('The prior pdf')
axis([0 1 0 5])
pause
post = prior;

for i=1:1:length(sequence)
    
    if sequence(i)=='a'
        post = post.*pa;
    else
        post = post.*(1-pa);
    end
    post = post./sum(post);
    post = post*length(pa);
    plot(pa,post)
    %%% points()....
    axis([0 1 0 5])
    title(['Coin came up ' sequence(i)])
    pause
    
end
