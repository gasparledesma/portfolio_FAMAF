set terminal postscript color
set output 'errors.ps'
set logscale xy
set xlabel 'Iteración (k)'
set ylabel 'Error relativo'
set title 'Errores relativos de los métodos de bisección y Newton-Raphson para √3'

# Plot bisection method relative errors
plot 'datos/bisection_errors.dat' using 1:2 with lines title 'Bisección', \
     'datos/bisection_errors.dat' using 1:3 with lines title 'Est. Bisección'

# Plot Newton-Raphson method relative errors
replot 'datos/newton_errors.dat' using 1:2 with lines title 'Newton-Raphson', \
       'datos/newton_errors.dat' using 1:3 with lines title 'Est. Newton-Raphson'
