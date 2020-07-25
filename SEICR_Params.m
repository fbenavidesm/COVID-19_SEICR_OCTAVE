% Calcula los parámetros del modelo SEICR en el orden:
%
%   I(0) = pin(1) 
%   beta = pin(2);
%   alpha = pin(3);
%   delta = pin(4);
%   gamma = pin(5);
%   eps = pin(6);
% 
% Este es el vector de retorno
% Como entrada se deben dar:
% 
% 1) Los datos crudos y
% 2) Número de días después de la primera ola T_cut
% 3) NP población susceptible


function pin = SEICR_Params (y, T_cut, NP)
  pin = zeros(6,1);
  ibd = SEICR_OptFW(y,NP,T_cut);
  pin(1) = ibd(1);
  pin(2) = ibd(2);
  pin(4) = ibd(3);
  NS = length(y);
  array = zeros(NS,1);
  for k = T_cut+1:NS
    array(k) = 1;
  end  
  eps = SEICR_OptSW(y,NP,array,ibd);
  pin(6) = eps;
  pin(3) = 1/5.5;
  pin(5) = 1/21;  
endfunction
