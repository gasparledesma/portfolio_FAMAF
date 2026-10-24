
###################     Problema 4 - Guia 1 ###########################




#########  Vamos a graficar las funciones y1(x), y2(x) junto con datos que sacamos
#########  del enunciado del Problema 4 y que pusimos en el archivo datos.dat
#########   en el directorio datos que debimos crear previamente a correr 
#########    esta script con el comando gnuplot script-P4.plt  


 y1 (x) = 0.5 * x +1.

 y2 (x) = 0.4 * x + 1.2



 #####################################################################
 

 set terminal wxt size 800 ,600 enhanced font 'Helvetica ,12 ' persist



 set title "Funciones lineales"



 #set style data lines



 set samples 200



  set xrange [ -.5:3.5]

  set yrange [ -.5:3.0]



 set key bottom right

 #set key left


 
  set xzeroaxis    ###     To simply have the x=0 axis drawn visibly:
 
  set yzeroaxis    ###     To simply have the y=0 axis drawn visibly:
 

 # Notar que el eje horizontal no aparece debido a que el rango automático

 # en 'y' no muestra regiones con 'y' < 0.



 set xlabel " x "

 set ylabel " funciones "



# si bien el problema habla de " datos.dat ", nosotros usaremos "datos/datos-p3.dat "


 set grid                      ##########   agrega grillas de forma automática  

 set mxtics 5                  #########    número de grillas en x 
 set mytics 5                  #########    número de grillas en y
  
 set grid mxtics mytics        ########    agrega las grillas seteadas en x y en y 



######   hacemos el plot de las dos columnas de datos del archivo en datos junto con 
######   funciones y1 y2, separados por comas usando \ para bajar al renglon de abajo 
######   agregandolos a todos en el mismo gráfico 



 plot "datos/datos-p4.dat" u 1:2 t " primer dato " w points pt 3 ps 4 , \
    "datos/datos-p4.dat" u 1:3 t " segundo dato " w points pt 5 ps 4, \
    y1(x) dashtype '.' lt 8 lw 3 , y2(x) dashtype '-' lw 4 lt 9 

###################################### para que el grafico salga en eps:


   set terminal postscript colour                   ########   postscript


#     set terminal postscrip {color | colour | monochrome }
#     set terminal postscript eps 14        # old epsf1
#     set terminal postscript eps 22         # old epsf2


     set output "graficos/p4-funciones-lineales.eps"




###################################### para que el grafico salga en pdf:


 

 # set terminal pdf enhanced font 'Helvetica,4'

 # set output "grafs/p4-funciones-linealesx.pdf"




 #################################### para que el grafico salga en png:




 # Notar que usamos "pngcairo" que es una versión png mejorada .

 set terminal pngcairo enhanced size 900,675

 set output "graficos/p4-funciones-linealesx.png"



  #####################################################################



 replot 

