% Esta función evalúa o resuelve la ecuación diferencial asociada al modelo
% SEICR, como se describe en:
%
% https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1
%
% Se devuelve el vector solución en pasos de una unidad, pero la ecuación
% es resuelta usando el método Runge-Kutta-Fehlberg, implementado dentro de los 
% algoritmos de Octave. La distribución de los parámetros de la función son:
%
% NP       población total (por ejemplo, 2.5 millones) 
% t        vector creciente con los días evaluados
%          ibd vector con los valores:
%               ibd(1)  = I(0), Número de infectados iniciales
%               ibd(2)  = beta, Valor de beta o tasa de transimisión
%               ibd(3) = delta, Tasa de confinamiento 
% ep       Valor de epsilon o tasa de devolución de la población susceptible, una vez
%          que se han aliviado las medidas de confinamiento.
% ag       Vector con los valores de alpha, ag(1) y gamma, ag(2). El valor de alpha es 
%          la tasa de incubación y el de gamma es la tasa de de eliminación (cuando el 
%          paciente se ha recuperado). 
% idx      Número de columna que se retorna como resultado de la función. Generalmente
%          es la columna número 3 (número de infectados) para optimizar con relación 
%          a los datos activos de las tablas de COVID-19
% lock_fun Puntero a la función de confinamiento (en relación  a "t"). 

function retval = SEICR_Eval(NP,t,ibd,ep,ag,idx,lock_fun)  
  i = ibd(1);
  beta = ibd(2);
  delta = ibd(3);  
  eps = ep;
  alpha = ag(1);
  gamma = ag(2);
  prms = [beta alpha delta gamma eps];  
  mod = @(t,y) SEICR_Model(t,y,prms,lock_fun);  
  S = NP-i; 
  E = 0;
  I = i;  
  C = 0;
  R = 0;  
  in_cond = (1/NP)*[S E I C R]; 
  [tn,y] = ode45(mod,t,in_cond);
  y = NP*y;
  if (idx  == 0)
    retval = y;
  else
    retval = y(:,idx);
  end  
endfunction