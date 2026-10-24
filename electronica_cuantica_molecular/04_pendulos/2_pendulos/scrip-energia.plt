####################    Grafica de 2 pendulos identicos para ver energia en el aclopamiento(?)

set term wxt persist

set ylabel 'Energia'
set xlabel 'w (Hz)'

set samples 100                       # Cantidad de puntos
set xrange [0:3]
set yrange [0:5]

# Graficar las funciones

i = sqrt(-1)
w_1 = 1.2
w_2 = 1.5
n_1 = 0.2
n_2 = 0.005

plot imag( (x**2 - (w_2**2 + i*w_2*n_2)) \
     / ( ((x**2 - (w_1**2 + i*w_1*n_1)) * (x**2 - (w_2**2 + i*w_2*n_2))) - 0.5**2 ) ) \
     title "Im[respuesta]" lc rgb "blue" with lines

###################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-energia.pdf"
replot
unset output  # Cierra el archivo

exit
