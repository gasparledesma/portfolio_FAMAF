####################    Problema 3   -  Guía 1 

set term wxt persist

set xlabel '{/Symbol h}/w_0'    # η es la h griega en la fuente Symbol
set ylabel '1/{/Symbol t}'      # τ es la t griega en la fuente Symbol




set samples 100                       # Cantidad de puntos

# Graficar ambas funciones juntas
plot (x/2) - real(sqrt(x/2 - 1)) title "Función impulsiva" lc rgb "red", \
     (x/2) + real(sqrt(x/2 - 1)) title "Función displasiva" lc rgb "blue", \
     x/2 title "{/Symbol h}/2" lc rgb "black" dt 2 with lines


set xrange [0:4]
set yrange [0:4]

replot

###################################  export as pdf gnuplot ##########################

set terminal pdfcairo enhanced font 'Helvetica,12'
set output "grafico3ECM.pdf"
replot
unset output  # Cierra el archivo
################################# export as png  gnuplot ########################
# set terminal pngcairo enhanced size 900,675
# set output "graficos/p3-oscilator.png"
# replot

exit
