####################    Grafica de orbitales atomicos

set term wxt persist

set ylabel '(1/pi)imgG_n'
set xlabel 'ε'

set samples 2000
set xrange [-0.9:2.9]
set yrange [0:0.55]


i = sqrt(-1)

ε_0 = 1
V = 1

Σ(x) = (x-ε_0)/2 + sqrt(((x-ε_0)/2)**2-V**2)


Σ_n(x,n)= V**2/(x-ε_0-Σ_n(x,n-1))

Gnn(x) = 1/(x-ε_0-Σ_n(x,n)-Σ(x))


Dnn(x) = (1.0/pi)*imag(Gnn(x))

plot Dnn(x) title "G_(nn)" lc rgb "blue" with lines ,


#######################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-Norbit.pdf"
replot
unset output  # Cierra el archivo


exit


