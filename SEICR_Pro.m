function retval = SEICR_Pro (data, pin, t, array, NP)
  lock_fun = @(t) g_lock(t,array); 
  ibd = [pin(1) pin(2) pin(4)];
  eps = pin(6);
  ag = [pin(3) pin(5)];  
  y = SEICR_Eval(NP,t,ibd,eps,ag,0,lock_fun);
  y_min = SEICR_Eval(NP,t,ibd,eps-0.3*eps,ag,0,lock_fun);
  y_max = SEICR_Eval(NP,t,ibd,eps+0.3*eps,ag,0,lock_fun);
  hold on;
  semilogy(y(:,3));
  semilogy(y_min(:,3),'g');
  semilogy(y_max(:,3),'g');
  semilogy(data,'*');
  grid on;
  hold off;
endfunction
