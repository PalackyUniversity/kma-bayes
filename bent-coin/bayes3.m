% Ilustrace Bayesovske inference
% Bent coin
% Tomas Furst podle David MacKay

% porovnavani dvou hypotez

Fa = 0; % zatim nepadlo nic
Fb = 0;
p = .3; % skutecna hodnota pst(padne a)

% H0 je hypoteza, ze p=1/6
% H1 je hypoteza, ze p \in (0,1)

pomery = nan(1000,1); % alokace na evidenci
pospomery = 1; % posice v poli pomery

while (Fa+Fb)<1000
    
    hod = (rand<p); % jednicka pokud padne a, nula jinak
    if hod % padlo a
        Fa = Fa+1;
    else % padlo b
        Fb = Fb+1;
    end
    
    %ev1 = (gamma(Fa+1)*gamma(Fb+1))/gamma(Fa+Fb+2); % evidence pro H1
    ev1 = beta(Fa+1,Fb+1);
    ev2 = ((1/6)^Fa)*((5/6)^Fb); % evidence pro H0
    pomer = ev1/ev2; % pomer evidenci pro H1 : pro H0
    pospomery = pospomery+1;
    pomery(pospomery) = pomer; % zapise
    
end

pospomery = pospomery+1;
pomery(pospomery:end) = []; % smaze prazdny kus pole

figure(1)
plot(log10(pomery)) % vykresli logaritmy
xlabel('poradi hodu')
ylabel('log10(ev1/ev2)')
title(['True p = ' num2str(p)])
    


