function retval = SEICR_Pro (data, pin, t, array, NP)
  lock_fun = @(t) g_lock(t,array); 
  ibd = [pin(1) pin(2) pin(4)];
  eps = pin(6);
  ag = [pin(3) pin(5)];  
  y = SEICR_Eval(NP,t,ibd,eps,ag,0,lock_fun);
  y_min = SEICR_Eval(NP,t,ibd,eps-0.3*eps,ag,0,lock_fun);
  y_max = SEICR_Eval(NP,t,ibd,eps+0.3*eps,ag,0,lock_fun);
 
  hold on;
  axis([1 length(t)]);
  tt = flip(t);
  yy = flip(y_max(:,3));
  fill ([t tt],[y_min(:,3)' yy'],'g');
  semilogy(y(:,3));
  semilogy(data,'*');
  grid on;
  title ("Proyecciones COVID-19, caso Costa Rica, modelo SEICR");
  xlabel ("Días después del día 1 de la pandemia"); 
  ylabel ("Casos activos");
  hold off;
endfunction
