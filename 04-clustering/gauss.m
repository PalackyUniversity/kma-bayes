% odhad mu a sigma z nahodneho vyberu z gaussovky
% David McKay chapter 22

mu_true = 1; % skutecna stredni hodnota
sigma_true = .4; % skutecna std

N = 15; % tolik mam datovych bodu
vals = mu_true + sigma_true*randn(N,1); % data

m = 0.6:.01:1.4;
s = .1:.01:1;
[mm ss] = meshgrid(m,s);

pom=0;
for i=1:1:N
    
    x = (mm - vals(i)).^2;
    y = 2*ss.^2;
    pom = pom + x./y;
    
end

L = -N*log(ss) - pom;

contour(mm,ss,L,100)