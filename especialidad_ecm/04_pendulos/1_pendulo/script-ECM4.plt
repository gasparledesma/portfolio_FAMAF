####################    Grafica de potencia

set term wxt persist

set ylabel '{/Symbol r}(w^2)'
set xlabel 'w^2/w_0^2'

set samples 100                       # Cantidad de puntos

set xrange [0:4]
set yrange [0:4]

# Graficar la parte imaginaria
i = sqrt(-1)
epsilon = 0.1

plot (-1/pi) * imag(1/(x-1 + epsilon*i)) title "Función impulsiva" lc rgb "red" with lines




###################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Helvetica,12'
set output "grafico-DvsW.pdf"
replot
unset output  # Cierra el archivo

exit
