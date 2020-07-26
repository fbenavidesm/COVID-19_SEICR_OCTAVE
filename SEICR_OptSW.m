% Optimizador del parámetro epsilon, correspondientes al análisis
% de la segunda ola de la pandemia. 
% Los parámetros por espicifar son:
%
% y           Datos crudos del número de datos activos
% NP          Población susceptible (2.5 millones para el caso de Costa Rica)
% lock_array  Arreglo del número de días por analizar, con un valor de 0 cuando
%             las medidas de confinamiento son aplicadas y 1 cuando no. 
% ibd         Valores de I(0), beta y delta en un vector 3x1               
%
% Esta función asume que las medidas de confinamiento ocurrieron tempranamente
% en la pandemia, como fue el caso de Costa Rica. Esas condiciones iniciales no 
% son cambiadas. Por eso es importante que el vector lock_array tenga 0 en las
% componentes de la primera ola de la pandemia. 
% El valor de retorno epsilon en el vector retval. 
% Para más detalles, consultar:
%
% https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1
%
function retval = SEICR_OptSW (y,NP,lock_array,ibd)
  Ts = length(y);
  t = 1:1:Ts;  
  t=t';
  ag = [1/6 1/21];
  eps = ag(2);
  idx = 3;
  lock_fun = @(t) g_lock(t,lock_array); 
  eval_fun = @(t,eps) SEICR_Eval(NP,t,ibd,eps,ag,3,lock_fun);
  [f, ep2, cvg, iter, corp, covp, covr, stdresid, Z, r2] = leasqr(t,y,eps,eval_fun,0.00000001,100,log(y+2));
  printf("Errores de aproximación (Segunda ola) \n"); 
  printf("R2: %f \n",r2); 
  printf("Intervalos de confianza 99 percentil: \n"); 
  printf("I(0): %f +- %f \n",ep2,norminv(1-0.01/2,0,covp(1,1))); 
  retval = ep2; 
endfunction
