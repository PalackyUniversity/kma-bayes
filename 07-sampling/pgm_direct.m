% Prob Graph Model
% Simulace jednoduche site
% Hlad --> Rve <-- Pocurane --> Smrdi


% simuluju x = (H,P,R,S) jako boolean
N = 1e7; % pro 1e7 uz to funguje hezky
vysl = false(N,4); % alokace na pocty situaci
% vysl(1) = [0 0 0 0] ... vysl(16) = [1 1 1 1]

disp('Simuluju ...')
tic

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
    vysl(i,:) = [H P R S];
end
toc
%% ted nase inference

% 1. p(H)
A = sum(vysl(:,1))/N; %OK tohle ma byt .3000

% 2. p(H | R) = p(H,R) / p(R)
B = sum(vysl(:,1) & vysl(:,3))/N; % p(H,R)
C = sum(vysl(:,3))/N; % p(R)
D = B/C; % p(H | R) OK tohle ma byt .7006

% 3. p(H | R,P) = p(H,R,P)/p(R,P)
E = sum(vysl(:,2) & vysl(:,3))/N; % p(R,P)
F = sum(vysl(:,1) & vysl(:,2) & vysl(:,3))/N; % p(H,R,P)
G = F/E; % p(H | R,P) OK tohle ma byt .414

% 4. p(H | R,S) = p(H,R,S)/p(R,S)
AA = sum(vysl(:,3) & vysl(:,4))/N; % rve a smrdi
BB = sum(vysl(:,1) & vysl(:,3) & vysl(:,4))/N; % p(H,R,S) OK ma byt .0699
CC = BB/AA; % p(H | R,S) OK ma byt .5810

% vypisy
disp(['Pocet iteraci = ' num2str(N)])
disp(['pst(H) = ' num2str(A) ', teoreticka pst = 0.3000'])
disp(['pst(H | R) = ' num2str(D) ', teoreticka pst = 0.7006'])
disp(['pst(H | R,P) = ' num2str(G) ', teoreticka pst = 0.414'])
disp(['pst(H | R,S) = ' num2str(CC) ', teoreticka pst = 0.5810'])










    


