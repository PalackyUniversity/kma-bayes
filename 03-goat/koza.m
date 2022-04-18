function [uhodl_puvodni,uhodl_zmenou]=koza(n)
% Simulace souteze o auto
% Jsou troje dvere - za jednemi dvermi je auto, za ostatnimi koza
% Soutezici tipne jedny dvere, reditel mu pak ukaze jedny jine dvere, 
% za kterymi je koza
% Ma zustat u sveho puvodniho rozhodnuti nebo ma zmenit rozhodnuti na treti
% dvere?
%
% Vstupni paramatry:
% n - pocet pokusu
% Vystupni paramatry:
% uhodl_puvodni - kolikrat uhodne ten, kdo rozhodnuti nezmeni
% uhodl_zmenou - kolikrat uhodne ten, kdo rozhodnuti zmeni

dvere=[1,2,3]; %mnozina dveri
auto=ceil(3*rand(n,1)); %kde je auto (nahodna cisla)
tip=ceil(3*rand(n,1)); % co soutezici tipuje (nahodna cisla)
vyber=ceil(2*rand(n,1)); %nahodny vyber ze dvou zbylych dveri
zmena=zeros(n,1);    % jen alokace pameti pro ulozeni zmenenych rozhodnuti
for i=1:n
    if (auto(i)==tip(i)) % pokud je auto za dvermi oznacenymi soutezicim
        dvere_k_otevreni=setdiff(dvere,[tip(i)]); % tipovane dvere neotevirame, tak je odecteme z nozim?y dveri
        zmena(i)=dvere_k_otevreni(vyber(i)); % ze zbylych dveri otevreme nahodne jedny
    else % pokud auto za oznacenymi dvermi neni a neni ani otevrenymi
        zmena(i)=auto(i); %muze byt jen za temi, na ktere se rozhodnuti zmeni
    end
end
% spocitame pocet uhodnutych aut
uhodl_puvodni=sum(auto==tip); % pokud zustane u puvodniho rozhodnuti
uhodl_zmenou=sum(zmena==auto); %pokud rozhodnuti zmeni
