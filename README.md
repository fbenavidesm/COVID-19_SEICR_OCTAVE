# COVID-19_SEICR_OCTAVE
Implementación en OCTAVE del modelo SEICR descrito en https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1

Los parámetros del modelo se pueden ajustar con una simple llamada al método:

SEICR_Params(y,T_cut,NP)

Donde y es el vector de datos activos crudos, T_cut demarca el día final de la primera ola, a partir del primer caso, y NP es la población total. Se supone que T_cut debe ser
menor que la longitud de y, que debería cubrir datos suficientes de la segunda ola para determinar completamente los parámetros. 
Los parámetros obtenidos pueden diferir de los descritos en https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1 lo cual puede deberse a varios factores aún por 
determinar:

  1) La optimización de los parámetros incluye condiciones iniciales
  2) El método usado, en casi todos los casos es el de Levenberg-Marquardt, como está implementado en Octave. La optimización basada en evolución diferencial no
     parece producir muchas diferencias
  3) Errores en la transcripción de los datos

Una vez ejecutada la obtención de los parámetros, es posible hacer proyecciones, usando diferentes arreglos de medidas de "baile" y "martillo", correspondiendo a un 0
un día en que se ha aplicado martillo y a un 1 un día de "baile". Es posible ensayar diferentes configuraciones de 1s y 0s para proyectar resultados diferentes de aplanamiento
de curva. 

Este software aún requiere validación, y tan sólo pretende ser una implementación, no basada en Mathematica, del método descrito en: 
https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1
