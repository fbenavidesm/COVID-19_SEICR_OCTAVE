% Optimizador de los parámetros: I(0), beta y delta, correspondientes al análisis
% de la primera ola de la pandemia. 
% Los parámetros por espicifar son:
%
% y      Datos crudos del número de datos activos
% NP     Población susceptible (2.5 millones para el caso de Costa Rica)
% T_cut  Tiempo en el que se desactivan las medidas de confinamiento
%
% Esta función asume que las medidas de confinamiento ocurrieron tempranamente
% en la pandemia, como fue el caso de Costa Rica. 
% El valor de retorno son los parámetros I(0), beta y delta en el vector retval. 
% Para más detalles, consultar:
%
% https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1
%


function retval = SEICR_OptFW (y,NP,T_cut)
  t = 1:1:T_cut;  
  t=t';
  y = y(1:T_cut);
  pin = [10 5 5];  
  eps = 0;
  ag = [1/6 1/21];
  idx = 3;
  lock_array = zeros(T_cut,1);
  lock_fun = @(t) g_lock(t,lock_array); 
  err_fun = @(pin) SEICR_Err(NP,t,pin,eps,ag,3,lock_fun,y);
  eval_fun = @(t,pin) SEICR_Eval(NP,t,pin,eps,ag,3,lock_fun);
  p = de_min(err_fun,"XVmin",[0 0 0],"XVmax",pin,"constr",1,"maxiter",40,"NP",20,...
                    "strategy",3,"CR",0.25,"F",0.8,"tol",0.00001);
  [f, p2, cvg, iter, corp, covp, covr, stdresid, Z, r2] = leasqr(t,y,p,eval_fun,0.00000001,100);
  printf("Errores de aproximación (primera ola) \n"); 
  printf("R2: %f \n",r2); 
  printf("Intervalos de confianza 99 percentil: \n"); 
  printf("I(0): %f +- %f \n",p2(1),norminv(1-0.01/2,0,covp(1,1))); 
  printf("Beta: %f +- %f \n",p2(2),norminv(1-0.01/2,0,covp(2,2))); 
  printf("Beta: %f +- %f \n",p2(3),norminv(1-0.01/2,0,covp(3,3))); 
  retval = p2; 
endfunction
