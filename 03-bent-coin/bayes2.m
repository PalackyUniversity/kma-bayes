% Ilustrace Bayesovske inference
% Bent coin
% Tomas Furst podle David MacKay

% ukazka postupneho update posterior
% naivni vypocet pomoci faktorialu

Fa = 0; % zatim nepadlo nic
Fb = 0;
p = 0.75; % skutecna hodnota pst(padne a)
pp = 0:.001:1; % argument posteriorni pst pro vykresleni
prior = ones(size(pp)); % rovnomerny pocatek

figure(1)
axis('manual')
plot(pp,prior)
axis([0 1 0 10])
xlabel('a')
ylabel('density')
title(['Uniform prior, true p = ' num2str(p) ' press any key to start'])

pause
while 1
    
    hod = (rand<p); % jednicka pokud padne a, nula jinak
    if hod % padlo a
        Fa = Fa+1;
    else % padlo b
        Fb = Fb+1;
    end
    
    pom = 1/beta(Fa+1,Fb+1);
    post = pom*(pp.^Fa).*((1-pp).^Fb);

    figure(1)
    hold off
    plot(pp,post)
    axis([0 1 0 10])
    xlabel('a')
    ylabel('density')
    title(['Posterior: Fa = ' num2str(Fa) ' and Fb = ' num2str(Fb)  ])
    
    pause(.03)    
%    pause
end


