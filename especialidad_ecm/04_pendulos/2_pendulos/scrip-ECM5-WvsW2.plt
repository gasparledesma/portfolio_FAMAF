####################    Grafica de potencia

set term wxt persist

set ylabel 'w^2'
set xlabel 'w^2/w_0^2'

set samples 100                       # Cantidad de puntos
set xrange [0:2]
set yrange [0:1.7]

# Graficar las funciones
plot (x+1)/2 - sqrt(((1-x)/2)**2 + 0.1**2) title "modo contrafase" lc rgb "red" with lines, \
     (x+1)/2 + sqrt(((1-x)/2)**2 + 0.1**2) title "modo simetrico" lc rgb "blue" with lines, \
     (x) title "W_x=0" lc rgb "black" dt 2 with lines, \
     (0*x + 1) title "w_1^2" lc rgb "green" dt 2 with lines

###################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-WvsW2.pdf"
replot
unset output  # Cierra el archivo

exit
