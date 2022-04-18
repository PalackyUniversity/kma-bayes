function argout = fpgm_reject(argin)

N = argin; % kolik simulaci
% argout bude 
% pst(H | R,S) , teoreticka pst = 0.5810

% Prob Graph Model
% Simulace jednoduche site
% Hlad --> Rve <-- Pocurane --> Smrdi

% simuluju x = (H,P,R,S) jako boolean
vysl = zeros(16,1); % alokace na pocty situaci
% vysl(1) = [0 0 0 0] ... vysl(16) = [1 1 1 1]
% tedy podle dvojkoveho kodu
kod = [8 4 2 1]; % na prevod do dvojkove

for i=1:1:N % cyklus simulaci

    H = rand<0.3; % Hlad
    P = rand<0.1; % Pocurane

    if H && P
        R = rand<.99;
    elseif H && ~P
        R = rand<.80;
    elseif ~H && P
        R = rand<.60;
    else % ~H && ~P
        R = rand<.10;
    end

    if P
        S = rand<.90;
    else %~P
        S = rand<.20;
    end

    % ted mam [H P R S]
    x = [H P R S];
    pos = sum(x.*kod);
    pos = pos+1; % tohle je cislo posice kam to napsat
    vysl(pos) = vysl(pos)+1;
end

% ted se v tom jeste vyznat:
% legenda je seznam moznych vysledku od [0 0 0 0] do [1 1 1 1] lexikograf.
% poradi je [H P R S]
legenda = zeros(16,4); % alokace na dvojkove kody
for i=1:1:16
    cis = i-1; % tohle prevest do dvojkove
    cis2 = dec2base(cis,2); % ve dvojkove jako char
    n = length(cis2);
    kus = repmat('0',[1,4-n]);
    cis3 = [kus cis2]; % nuly vepredu
    for j=1:1:4
        if cis3(j)=='1'
            legenda(i,j)=1;
        end
    end
end


% p(H | R,S) = p(H,R,S)/p(R,S)
kde = legenda(:,3)==1 & legenda(:,4)==1; % rve a smrdi
cit = sum(vysl(kde));
AA = cit/N; % p(R,S) OK ma byt .1203
kde = legenda(:,1)==1 & legenda(:,3)==1 & legenda(:,4)==1; % hlad a rve a smrdi
cit = sum(vysl(kde));
BB = cit/N; % p(H,R,S) OK ma byt .0699
CC = BB/AA; % p(H | R,S) OK ma byt .5810

argout = CC;








    


