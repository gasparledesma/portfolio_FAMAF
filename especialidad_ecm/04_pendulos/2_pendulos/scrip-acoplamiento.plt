####################    Grafica de 2 pendulos identicos para ver energia en el aclopamiento(?)

set term wxt persist

set ylabel '{/Symbol r}(w^2)'
set xlabel 'w^2/w_0^2'

set samples 100                       # Cantidad de puntos
set xrange [2:2]
#set yrange [-10:60]

# Graficar las funciones
    
        #i   = sqrt(-1)
        #w_1 = 1.5
        #w_2 = 1.0
        #w_x = 0.7
        #
        #M_12 = - w_x**2     # positivo
        #M_21 = - w_x**2     # positivo
        #d_1 = 0.01        # pequeño para picos nítidos
        #d_2 = 0.01        # pequeño para picos nítidos
    #
    #
        #rho(x) = (-1/pi) * imag( (1/(x**2 - w_2**2 + i*d_2)) * M_21 * ( 1 / ( (x**2 - w_1**2 + i*d_1) - M_12*(1/(x**2 - w_2**2 + i*d_2))*M_21 ) ) )
    #
        ##plot (-1/pi) * imag( (1/(x - w_2**2+i*d_2)) * M_21 * ( 1 / ( (x - w_1**2 + i*d_1) - M_12*(1/(x - w_2**2 + i*d_2))*M_21 ) ) ) 
        #  ##title "Im[respuesta]" lc rgb "blue" with lines
    #
    #
        #plot rho(x) title "Im[respuesta]" lc rgb "blue" with lines
    
#prueba222
    # Parámetros del sistema
    #i = sqrt(-1)
    #w_1 = 1.5
    #w_2 = 1.0
    #w_x = 0.7       # acoplamiento moderado

    #M_12 = - w_x**2   # signo negativo
    #M_21 = - w_x**2   # signo negativo
    #d_1 = 0.01        # amortiguamiento pequeño
    #d_2 = 0.01        # amortiguamiento pequeño

    ## Función rho(x)
    #rho(x) = (-1/pi) * imag( (1/(x**2 - w_2**2 + i*d_2)) * M_21 * ( 1 / ( (x**2 - w_1**2 + i*d_1) - M_12*(1/(x**2 - w_2**2 + i*d_2))*M_21 ) ) )

    ## Graficar la función
    #plot rho(x) lw 2 title "Dos picos positivos"



i = sqrt(-1)
delta1 = 0.1
w_12 = 1
w_22 = 1
delta2= 0.1
M_12 = 0.5
M_21 = 0.5




plot (-1/pi) * imag(1/(x- w_12 + delta1*i-M_12*(1/(x-w_22+i*delta2))*M_21)) title "Función impulsiva" lc rgb "red" with lines



# Parámetros
    #w1 = 1.5
    #w2 = 1.0
    #wx = 1.0
    #i   = sqrt(-1)
    #M12 = wx**2
    #M21 = wx**2
    #d1 = 0.05
    #d2 = 0.05
    #
    ## Función rho(x)
    #rho(x) = (1.0/pi) * imag( M21 / (x - w2**2+i*d2) / ( (x - w1**2 + i*d1) - M12 / (x - w2**2 + i*d2) * M21 ) )
    #
    ## Configuración de la gráfica
    #set xrange [0:3]
    #set yrange [0:*]
    #set xlabel "x"
    #set ylabel "rho(x)"
    #set grid
    #
    ## Graficar
    #plot rho(x) lw 2 title "Dos picos positivos"
#prueba


###################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-acople.pdf"
replot
unset output  # Cierra el archivo

exit
