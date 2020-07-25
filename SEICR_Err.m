% Función de error para estimar la efectividad de una solución del modelo
% SEICR con respecto a los datos dados en y. 

function retval = SEICR_Err(NP,t,pin,eps,ag,idx,lock_fun,y)
  w = SEICR_Eval(NP,t,pin,eps,ag,idx,lock_fun);
  err = y-w;
  retval = dot(err,err);
endfunction
