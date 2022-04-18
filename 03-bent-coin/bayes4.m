% Ilustrace Bayesovske inference
% Bent coin
% Tomas Furst podle David MacKay

% ukazka postupneho update posterior
% tohle uz je chytrejsi, numericka implementace

Fa = 0; % zatim nepadlo nic
Fb = 0;
p = 0.6; % skutecna hodnota pst(padne a)
pp = 0:.001:1; % argument posteriorni pst pro vykresleni
post = ones(size(pp)); % rovnomerny pocatek
normalisace = sum(post); % tohle je soucet hustoty
% ted ho znacim jako posterior, protoze budu delat update

figure(1)
axis('manual')
plot(pp,prior)
axis([0 1 0 50])
xlabel('a')
ylabel('density')
title(['Uniform prior, true p = ' num2str(p) ' press any key to start'])

pause
while (Fa+Fb)<10000
    
    hod = (rand<p); % jednicka pokud padne a, nula jinak
    if hod % padlo a
        Fa = Fa+1;
        post = post.*pp; % update
        post = post./sum(post); % normalisace
        post = normalisace*post; % na jednicku
    else
        Fb = Fb+1;
        post = post.*(1-pp); % update
        post = post./sum(post); % normalisace
        post = normalisace*post; % na jednicku
    end
    
    figure(1)
    hold off
    plot(pp,post)
    axis([0 1 0 50])
    xlabel('a')
    ylabel('density')
    title(['Posterior: Fa = ' num2str(Fa) ' and Fb = ' num2str(Fb)  ])
    
    pause(.001) % trochu rychleji nez minule
    
end


