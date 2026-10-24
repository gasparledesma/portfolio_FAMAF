set term wxt persist

set ylabel '{/Symbol r}(w^2)'
set xlabel 'w^2/w_0^2'

set samples 2000
set xrange [0:2]
#set yrange [0:10]

############ FORMULA ##########

    ####i = sqrt(-1)
    ####delta1 = 0.05
    ####delta2 = 0.05
    ####delta3 = 0.05
    ####
    ####w_11 = 1.0
    ####w_22 = 1.0
    ####w_33 = 1.0
    ####w_x  = 0.3
    ####
    ##### Definimos los elementos de la matriz M
    ####M11(x) = x - w_11 + i*delta1
    ####M22(x) = x - w_22 + i*delta2
    ####M33(x) = x - w_33 + i*delta3
    ####
    ##### Determinante de M
    ####Det(x) = M11(x)*(M22(x)*M33(x) - w_x**2) - \
    ####         (-w_x)*(-w_x*M33(x))              # expansión por primera fila
    ####
    ##### Derivada del determinante (a mano)
    ####Detp(x) = 1*(M22(x)*M33(x) - w_x**2) + \
    ####          M11(x)*(1*M33(x)) + \
    ####          M11(x)*(M22(x)*1)
    ####
    ##### Entonces la traza es:
    ####TrD(x) = Detp(x)/Det(x)
    ####
    ##### Finalmente densidad de estados
    ####rho(x) = -(1./pi)*imag(TrD(x))
    ####
    ####plot rho(x) title "Densidad de estados total" lc rgb "red" with lines
    ####
    ####


i = sqrt(-1)
delta1 = 0.05
delta2 = 0.01
delta3 = 0.05


w_11 = 1.0
w_22 = 1.0
w_33 = 1.0
w_x  = 0.3

a(x) = x - w_11 + i*delta1
b(x) = x - w_22 + i*delta2
c(x) = x - w_33 + i*delta3
k    = w_x

D11(x) = 1.0 / ( a(x) - k**2 / ( b(x) - k**2 / c(x) ) )
D22(x) = 1.0 / ( b(x) - k**2 / a(x) - k**2 / c(x) )
D33(x) = 1.0 / ( c(x) - k**2 / ( b(x) - k**2 / a(x) ) )

rho_sum(x) = -(1.0/pi)*imag( D11(x) + D22(x) + D33(x) )

plot rho_sum(x) title "Densidad total (suma de Dii)" lc rgb "blue" with lines



#######################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-D11+D22+D33.pdf"
replot
unset output  # Cierra el archivo


exit
