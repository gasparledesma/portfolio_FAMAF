####################    Grafica de orbitales atomicos en cadena infinita

set term wxt persist
set ylabel '(1/pi) Im G_nn'
set xlabel 'ε'

set samples 2000
set xrange [-3:3]
set yrange [0:0.6]

i = sqrt(-1)

# ----------------- parámetros
ε_0 = 1.0
V   = 1.0
eta = 0.05   # pequeño desplazamiento imaginario (i*eta)

# ----------------- Sigma auto-consistente (semi-cadena infinita a la derecha)
Sigma_iter(x, n) = (n==0) ? 0 : (V**2)/(x-ε_0 + i*eta - Sigma_iter(x,n-1))
Sigma(x) = Sigma_iter(x,30)   # 30 iteraciones, suficiente para converger

# ----------------- Fracción continua hacia la izquierda
Frac(x,n) = (n==0) ? Sigma(x) : (V**2)/(x-ε_0 + i*eta - Frac(x,n-1))

# ----------------- Green local en el sitio n
Gnn(x,n) = 1.0/(x-ε_0 + i*eta - Frac(x,n-1))

# ----------------- densidad de estados local (LDOS)
Dnn(x,n) = (1.0/pi)*imag(Gnn(x,n))

# ----------------- Graficar distintos sitios
plot Dnn(x,1) title "G_(11)" lc rgb "red" with lines, \
     Dnn(x,2) title "G_(22)" lc rgb "black" with lines, \
     Dnn(x,3) title "G_(33)" lc rgb "green" with lines, \
     Dnn(x,8) title "G_(88)" lc rgb "blue" with lines

#######################################  export as pdf ##########################
set terminal pdfcairo enhanced font 'Sans,12'
set output "grafico-Gnn.pdf"
replot
unset output
exit
