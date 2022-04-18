function argout = fpgm_gibbs(argin)

N = argin;
% argout bude 
% pst(H | R,S) , teoreticka pst = 0.5810


% Prob Graph Model
% Simulace jednoduche site
% Hlad --> Rve <-- Pocurane --> Smrdi
% tentokrat pomoci MCMC Gibbs sampling
% OK funguje!!

% simuluju x = (H,P,R,S) jako boolean
% evidence: R=1, S=1 ten slozitejsi pripad pro kontrolu
vysl = zeros(4,1); % alokace na pocty situaci
% vysl(1) = [0 0] ... vysl(4) = [1 1] jen H a P
% tedy podle dvojkoveho kodu
kod = [2 1]; % na prevod do dvojkove

state = [1 1]; % H P inicialisace

for i=1:1:N % cyklus simulaci

    if rand<0.5; % updatuju Hlad
        
        if state(2)==1 % P==1
            
            pst = .414; % p(H+ | R+S+P+)
            if rand<pst
                state(1)=1; % H+
            else
                state(1)=0; % H-
            end
            
        else % state(2)==0, tedy P==0
            
            pst = .774; % p(H+ | R+S+P-)
            if rand<pst
                state(1)=1; % H+
            else
                state(1)=0; % H-
            end
        end
        
    else % updatuju P

        if state(1)==1 % H==1
            
            pst = .382; % p(P+ | R+S+H+)
            if rand<pst
                state(2)=1; % P+
            else
                state(2)=0; % P-
            end
            
        else % state(1)==0 % H=0
            
            pst = .750; % p(P+ | R+S+H-)
            if rand<pst
                state(2)=1; % P+
            else
                state(2)=0; % P-
            end
        end
    end

    % ted mam novy stav [H P]
    pos = (kod.*state);
    pos = sum(pos)+1; % posice ve vysl
    vysl(pos) = vysl(pos)+1;
    
end

% ted nase inference
% p(H | R,S)
pom = sum(vysl(3:4))/sum(vysl(:));
argout = pom;



