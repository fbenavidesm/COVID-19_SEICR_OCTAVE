% Modelo SEICR tal y como se describe en:
% https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1
%
% Básicamente se reciben como parámetros un valor del tiempo t y la condicion
% actual y. El método SEICR_Model devuelve f(t,y) donde y' = f(t,y) es el modelo SEICR 
% descrito. También se debe indicar el valor de los parámetros en el vector "pin"
% en el siguiente orden:
% 
%   beta = pin(1);
%   alpha = pin(2);
%   delta = pin(3);
%   gamma = pin(4);
%   eps = pin(5);
%
% Además, el puntero a la función lock_fun determina si hay medidas de distanciamiento
% (en cuyo caso su valor es 0) o no (valor 1). 
% Los valores de las variables SEICR están normalizados. 


function retval = SEICR_Model(t, y, pin,lock_fun)    
  S = y(1);
  E = y(2);
  I = y(3);
  C = y(4);
  R = y(5);
  beta = pin(1);
  alpha = pin(2);
  delta = pin(3);
  gamma = pin(4);
  eps = pin(5);
  
  dS = -(beta)*S*I-(1-lock_fun(t))*delta*S + lock_fun(t)*eps*C;
  dE = (beta)*S*I - alpha*E;
  dI = alpha*E - gamma*I;  
  dC = (1-lock_fun(t))*delta*S - lock_fun(t)*eps*C;
  dR = gamma*I;
  retval = [dS dE dI dC dR];
endfunction