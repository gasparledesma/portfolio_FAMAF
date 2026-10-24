set term wxt persist

set ylabel 'w^2'
set xlabel 'w^2/w_0^2'

set samples 2000
#set xrange [0:2]
#set yrange [0:10]

########## FUNCION  #################3

    w_11 = 1.0
    w_22 = 1.0
    w_33 = 1.0
    w_x  = 0.3

    M_0 = 1
    M_x = 1


    w(x) = M_0*x - sqrt(2*x*(M_0**2))
    w_2(x) = M_0*x + sqrt(2*x*(M_x**2))
    w_3(x) = M_0**2 *x

    plot w(x) title "w_x" lc rgb "blue" with lines , \
    w_2(x) title "w_2" lc rgb "red" with lines , \
    w_3(x) title "w_3" lc rgb "black" with lines




#######################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-w.pdf"
replot
unset output  # Cierra el archivo


exit

