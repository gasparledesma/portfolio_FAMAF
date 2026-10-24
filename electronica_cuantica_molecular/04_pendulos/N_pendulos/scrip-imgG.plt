####################    Grafica de orbitales atomicos

set term wxt persist

set ylabel '(1/pi)imgG'
set xlabel 'ε'

set samples 2000
set xrange [-0.9:2.9]
set yrange [0:0.55]


i = sqrt(-1)

ε_0 = 1
V = 1

Σ(x) = (x-ε_0)/2 + sqrt(((x-ε_0)/2)**2-V**2)

Gii(x) = 1/(x-ε_0-2*Σ(x))
G11(x) = 1/(x-ε_0-Σ(x))
G22(x) = 1/(x-ε_0-(V**2/(x-ε_0))-Σ(x))
G33(x) = 1/(x-ε_0-(V**2/(x-ε_0-(V**2/(x-ε_0))))-Σ(x))

Dii(x) = (1.0/pi)*imag(Gii(x))

plot Dii(x) title "G_(ii)" lc rgb "blue" with lines , \
imag(G11(x))*(1.0/pi) title "G_(11)" lc rgb "red" with lines , \
imag(G22(x))*(1.0/pi) title "G_(22)" lc rgb "black" with lines , \
imag(G33(x))*(1.0/pi) title "G_(33)" lc rgb "green" with lines


#######################################  export as pdf gnuplot ##########################
set terminal pdfcairo enhanced font 'Sans,12'

set output "grafico-Gii.pdf"
replot
unset output  # Cierra el archivo


exit


