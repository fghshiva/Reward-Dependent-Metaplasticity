function S = fSimulateRDMP(param, Stimulus)
% fSimulateRDMP models models a simple RDMP model for 
%
%   Inputs:
%       Stimulus:               structure of input 
%             Stimulus.prob         probability of reward for a color
%       param:                  structure of parameters value
%             param.nState          number of meta-states
%             param.ratep           transition probability
%             param.rateq           transition probability
%
%   Output:
%       C                       synaptic effecacy of synapses
%             C.strong:             synaptic effecacy of synapses in strong meta-states
%             C.weak:               synaptic effecacy of synapses in weak meta-states

%% AUTHOR    : Shiva Farashahi
%% DATE      : 09-Mar-2017
%% Revision  : 1.
%% DEVELOPED : 8.5.0.197613 (R2015a)
%% FILENAME  : fSimulateRDMP.m

%%

N               = 2*param.nState ;
% potentiation matrix
decayRate       = [param.ratep param.rateq] ;
decayRateP      = decayRate(1);
decayRateQ      = decayRate(2);
pArray          = [(decayRateP.^(N/2-1:-1:1)), 0, (decayRateP.^(1:N/2-1))];
qArray          = [zeros(1,N/2), decayRateQ.^(((N/2 -2) * (1:N/2)  +1) /(N/2 - 1))];
tmp             = diag(pArray, 1) +[zeros(N/2-1,N); qArray; zeros(N/2,N)];
potentiation    = eye(N,N) + tmp - diag(sum(tmp));

% depression matrix
decayRate       = [param.ratep param.rateq] ;
decayRateP      = decayRate(1);
decayRateQ      = decayRate(2);
pArray          = [(decayRateP.^(N/2-1:-1:1)), 0, (decayRateP.^(1:N/2-1))];
qArray          = [zeros(1,N/2), decayRateQ.^(((N/2 -2) * (1:N/2)  +1) /(N/2 - 1))];
tmp             = diag(pArray, 1) +[zeros(N/2-1,N); qArray; zeros(N/2,N)];
depression      = eye(N,N) + tmp - diag(sum(tmp));
depression      = depression(N:-1:1,N:-1:1);

SEinit          = ones(1,2*param.nState)*(1/(2*param.nState)) ; 
SE              = SEinit' ;

for t = 1:length(Stimulus.prob)
    % closed rom simulation: 
    % on each trial with p we potentiate and with and (1-p) we depress the synaptic effecacy
    SE                  = SE + ( (potentiation-eye(2*param.nState))*Stimulus.prob(t) + (depression-eye(2*param.nState))*(1-Stimulus.prob(t)) )*SE ;
    S.strong(t,:)       = SE(param.nState:-1:1) ;
    S.weak(t,:)         = SE(param.nState+1:2*param.nState) ;
end
end