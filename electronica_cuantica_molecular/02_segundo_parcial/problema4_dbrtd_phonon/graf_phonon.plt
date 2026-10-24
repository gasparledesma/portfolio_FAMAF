reset

# =============================================================================
# CONFIGURACIÓN GENERAL
# =============================================================================
set grid
set xrange [-3.0:3.0]
set yrange [-0.05:1.05]

# Estilos de Línea bien definidos
set style line 1 lc rgb "black" lw 2             # T Total
set style line 2 lc rgb "blue" lw 2              # T Elástica (Canal central)
set style line 3 lc rgb "red" lw 2               # T Emisión (-w0)
set style line 4 lc rgb "forest-green" lw 2      # T Absorción (+w0)

datos = "datos/fock_inelastic.dat"

# =============================================================================
# GRÁFICO: ESPECTRO DE TRANSMISIÓN INELÁSTICA
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,6in
set output "graficos/Resultados_Prob4_Inelastico.pdf"

set title "Problema 4: DBRTD con Fonón Local (Espacio de Fock)" font ",14"
set ylabel "Transmitancia (Canales)"
set xlabel "Energía Incidente del Electrón (E)" 
set key top right box

# Marcadores verticales para visualizar las energías de los fonones
set arrow from -1.0, 0 to -1.0, 0.4 nohead lc rgb "gray" dt 3
set arrow from  1.0, 0 to  1.0, 0.4 nohead lc rgb "gray" dt 3

plot datos using 1:5 with lines ls 1 title "T_{Total} (Suma de Canales)", \
     datos using 1:2 with lines ls 2 title "T_{Elástica} (Resonancia E_r = 0)", \
     datos using 1:3 with lines ls 3 title "T_{Emisión} (Satélite E_r + \hbar{/Symbol w}_0)", \
     datos using 1:4 with lines ls 4 title "T_{Absorción} (Satélite E_r - \hbar{/Symbol w}_0)"

unset output
print "Gráfico PDF generado."

# =============================================================================
# PANTALLA INTERACTIVA
# =============================================================================
set term wxt persist size 900,500 font "Sans,11"
replot