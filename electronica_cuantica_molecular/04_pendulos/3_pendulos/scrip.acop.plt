####################    Grafica de 3 pendulos identicos para ver energia en el aclopamiento(?)

set term wxt persist

set ylabel 'D_11'
set xlabel 'w^2'


set samples 2000
set xrange [0.5:1.5]
#set yrange [-1:5]




    #### FORMULA  #######
    i = sqrt(-1)
    delta1 = 0.02
    delta2 = 0.02
    delta3 = 0.02


    w_11 = 1.0
    w_22 = 1.0
    w_33 = 1.0

    w_x = 0.3
   




    plot (-1/pi) * imag(1/(x- w_11 + delta1*i-w_x*(1/(x-w_22+i*delta2+(w_x*w_x/(x-w_33+i*delta3))))*w_x)) title "ImagD11" lc rgb "red" with lines


###################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-acople3.pdf"
replot
unset output  # Cierra el archivo

exit
