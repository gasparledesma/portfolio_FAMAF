####################    Grafica de 2 pendulos identicos para ver si sincronizacion

set term wxt persist

set ylabel '{/Symbol u}'
set xlabel 't'

set samples 100                       # Cantidad de puntos
set xrange [0:14]
set yrange [-1:1]

# Graficar las funciones

plot cos(0.1*2*pi*x)*cos(4*pi*x) title "u_1(t) con CI displaciva" lc rgb "blue" with lines,\
    (x*0) title "" lc rgb "black" with lines

###################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-pendindt.pdf"
replot
unset output  # Cierra el archivo

exit
