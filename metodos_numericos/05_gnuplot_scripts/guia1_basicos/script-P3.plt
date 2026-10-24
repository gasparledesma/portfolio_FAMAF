
####################    Problema 3   -  Guía 1 






    set term x11 persist           ####### esto hace que el plot permanezca abierto
   

    set xlabel 'Time (seconds)'                   ##### label del eje x         
    set ylabel 'Displacement (centimeters)'       ##### label del eje y
      
    set samples 500                              ####### número de puntos a graficar


    plot sin(6.3*x) title "sin(2{/Symbol pi}x)"    ##### plot de la función con rango automático
        

     ######  ahora fijo los rangos en x y en y para hacer replot y despues exporto un gráfico
     ######   puedo elegir alguno de los tres formatos y descomentarlo     

        
     set xrange [ 0:5 ]
     set yrange [-1.2:1.2]

     replot


###################################   export as eps color or black and white gnuplot ############## 



#   set terminal postscript monochrome               ########  old postscript
    
#   set terminal postscrip {color | colour | monochrome }
#   set terminal postscript eps 14         # old epsf1
    set terminal postscript eps 22         # old epsf2

#   set output "graficos/p3-oscilator.eps"



###################################  export as pdf gnuplot ##########################


 

    set terminal pdf enhanced font 'Helvetica,4'

    set output "graficos/p3-oscilator.pdf"




################################# export as png  gnuplot ########################



###### Notar que usamos "pngcairo" que es una versión png mejorada .


# set terminal pngcairo enhanced size 900,675

# set output "graficos/p3-oscilator.png"



 replot



####################################################################################################



 exit




        
