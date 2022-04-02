% Ilustrace Bayesovske inference
% Bent coin
% Tomas Furst podle David MacKay

% F = Fa + Fb je celkovy pocet hodu a padlych acek a becek
% Jen ilustrujeme posteriorni pst za uniform prior

Fa = 3; % tolik padlo acek
Fb = 7; % tolik padlo becek

pp = 0:.001:1; % argument posteriorni pst pro vykresleni
pom = factorial(Fa+Fb+1)/(factorial(Fa)*factorial(Fb));
% pomoci faktorialu
pom1 = gamma(Fa+Fb+2)/(gamma(Fa+1)*gamma(Fb+1));
% pomoci gamma funkce je to o trochu chytrejsi
pom2 = 1/beta(Fa+1,Fb+1);
% jeste chytrejsi verze

post = pom2*(pp.^Fa).*((1-pp).^Fb);
expect = sum(pp.*post)/length(pp);

figure(1)
hold off
plot(pp,post)
hold on
xx = [0.5 0.5]; yy = [0 max(post)];
plot(xx,yy,'g')
prop = Fa/(Fa+Fb);
xx = [prop prop]; 
plot(xx,yy,'r')
xx = [expect expect];
plot(xx,yy,'k')

xlabel('a')
ylabel('density')
title(['Posterior on pa from Fa = ' num2str(Fa) ' and Fb = ' num2str(Fb)  ])
legend('posterior','prior mean','proportion','posterior mean')


