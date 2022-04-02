% simulace na podminene gaussovaky
% Tomas Furst podle Chris Bishop

mu = [1;2]; % stredni hodnoty 2D normaniho rozdeleni
sigma = [3 1; 1 3]; % variancni matice
[vv vc] = eig(sigma); % ukazat:)
xx = -3:.01:5;
yy = -2:.01:6;
[X Y] = meshgrid(xx,yy); % sit na zobrazeni
pom1 = 1/(2*pi);
pom2 = 1/sqrt(det(sigma));
invs = inv(sigma); % invers variancni matice
Z = nan(size(X));
for i=1:1:length(xx)
    for j=1:1:length(yy)
        
        x = X(i,j);
        y = Y(i,j); % tady stojim
        vek = [x; y] - mu;
        pom3 = vek'*(invs*vek);
        Z(i,j) = pom1*pom2*exp(-0.5*pom3);
        
    end
end

figure(1)
mesh(X,Y,Z)
title('Density of 2D gaussian')

figure(2)
contour(X,Y,Z)
xlabel('x1')
ylabel('x2')
title('Contour plot of 2D gaussian')

% ted conditional gauss
% jdeme po radcich matice X (prot promenna) 
% v danem radky je vzdy jedna hodnota matice Y
% na radku matice Z je un-normalized gaussian

figure(3)
mivcera = 0;
for radek = 1:11:size(X,1)

    vals = Z(radek,:);
    vals = vals./max(vals); % podvod na normalisaci
    x2 = Y(radek,1); % v tomto bode conditional
    plot(xx,vals)
    xlabel('x1')
    ylabel('normalized section')
    
%    title(['Conditional for x2 = ' num2str(x2)])

    kde = find(vals==max(vals)); % bod maxima je stredni hodnota
    midnes = xx(kde); % stredni hodnota

    kus = vals((kde-200):(kde+200)); % kus kolem stredu (quick fix)
    plocha = sum(kus)/400; % integral toho kusu jako proxy pro var
    
    title(['MuDnes - MuVcera = ' num2str(midnes - mivcera) ', Sirka = ' num2str(plocha)])
    pause
    
    mivcera = midnes;
end






