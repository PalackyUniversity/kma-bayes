% Ilustrace priklady z kapitoly 3 Davida MacKaye

x = [1.5 2 3 4 5 12]; % v techto bodech pozoruju rozpad castice
% pozorovat mohu jen mezi x=1 a x=20
% vim, ze misto rozpadu ma exp rozdeleni
% mam odhadnout lambda

% napred vykreslime pst(x|lam) pro ruzna lambda
figure(1)
lam = [2; 3; 5; 10; 20]; % jen ilustrace
legenda = [cellstr('p(x|lam=2)'); cellstr('p(x|lam=3)'); cellstr('p(x|lam=5)');...
    cellstr('p(x|lam=10)'); cellstr('p(x|lam=20)')];
barvy = ['r'; 'g'; 'b'; 'k'; 'm']; % barvy

xx = 1:.01:20; % pozorovane okno
for i=1:1:length(lam)
    
    llam = lam(i); % aktualni lambda
    norma = exp(-1/llam) - exp(-20/llam); % normalisacni podminka
    pst = (1/llam).*exp(-xx/llam);
    pst = pst./norma;
    plot(xx,pst,'Color',barvy(i));
    hold on
    axis([1 20 0 0.5]);
    
end
    
legend(legenda);
xlabel('x')
ylabel('pst(x|lam)')
title('Nekolik prenormovanych exponencialnich rozdeleni')

%% animace naopak

x = [3 4 5 12]; % v techto bodech pozoruju rozpad castice
legenda = [cellstr('p(x=3|lam)');...
    cellstr('p(x=4|lam)'); cellstr('p(x=5|lam)'); cellstr('p(x=12|lam)')];
barvy = ['r'; 'g'; 'b'; 'k'; 'm'; 'c']; % barvy
figure(2)
lam = 0:.1:50; % grafika
for i=1:1:length(x)
    
    xx = x(i); % aktualni lambda
    norma = exp(-1./lam) - exp(-20./lam); % normalisacni podminka
    pst = (1./lam).*exp(-xx./lam);
    pst = pst./norma;
    plot(lam,pst,'Color',barvy(i));
    pause
    hold on
    
end
    
legend(legenda);
xlabel('lambda')
ylabel('pst(x|lam)')
title('Nekolik likelihoodu')

%% ted naopak (neni tam nic videt)

x = 3:0.1:20;
lam = 1:0.1:15;
[X LAM] = meshgrid(x,lam);
NOR = exp(-1./LAM) - exp(-20./LAM); % normalisacni podminka
PST = (1./LAM).*exp(-X./LAM);
PST = PST./NOR;
figure(3)
surf(X,LAM,PST)
xlabel('x')
ylabel('lam')
zlabel('pst(x|lam)')
title('Pravdepodobnost a likelihood v jednom')


%% ted to co nas skutecne zajima: ten soucin

x = [1.5 2 3 4 5 12]; % v techto bodech pozoruju rozpad castice

lam = 0:.1:20; % grafika
likelihood = ones(size(lam)); % alokace na LH

for i=1:1:length(x)
    
    xx = x(i); % aktualni lambda
    norma = exp(-1./lam) - exp(-20./lam); % normalisacni podminka
    pst = (1./lam).*exp(-xx./lam);
    pst = pst./norma;
    likelihood = likelihood.*pst; % postupne nasobim
    
end

figure(4)
plot(lam,likelihood)
xlabel('lambda')
ylabel('likelihood')
title('Celkovy likelihood')





