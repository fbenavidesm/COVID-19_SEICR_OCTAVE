% Función de confinamiento en el tiempo "t" con respecto a un vector de días
% lock_array que tiene 1 cuando no hay confinamiento y 0 cuando sí lo hay.
% Esto permite un ajuste fino de los día de confinamiento. 

function retval = g_lock (t,lock_array)
  t = round(t);
  if (t > length(lock_array))
    t = length(lock_array);
  end  
  retval = lock_array(t);
endfunction
