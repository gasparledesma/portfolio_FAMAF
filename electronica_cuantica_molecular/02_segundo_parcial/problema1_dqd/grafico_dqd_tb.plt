reset

# =============================================================================
# CONFIGURACIÓN GENERAL
# =============================================================================
set grid
set xrange [-4.5:4.5]

# Fijamos Y para la Transmisión (probabilidad va de 0 a 1)
set yrange [-0.05:1.05]

# Estilos de Línea
# ls 1: DQD Simple (Gris punteado para referencia)
set style line 1 lc rgb "gray40" dt 2 lw 2      
# ls 2: Anillo con Flujo 0 (Azul)
set style line 2 lc rgb "blue" lw 2             
# ls 3: Anillo con Flujo Pi (Rojo)
set style line 3 lc rgb "red" lw 2              

# Archivo de datos (Asegúrate de que el nombre coincida con la salida de Fortran)
datos = "DQD_transmision.dat"

# =============================================================================
# PDF: TRANSMISIÓN DQD Y EFECTO AHARONOV-BOHM
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "Resultados_Transmision_DQD.pdf"

set multiplot layout 2,1 title "Transporte Cuántico: DQD y Efecto Aharonov-Bohm" font ",16"


set title "Interferencia destructiva por el estado lateral (Flujo {/Symbol a} = 0)" font ",12"
set ylabel "Transmisión T(E)"
set xlabel "Energía (E)" 
set key bottom center horizontal box
plot datos using 1:2 with lines ls 1 title "DQD Simple (Sin C)", \
     datos using 1:3 with lines ls 2 title "Anillo ({/Symbol a} = 0)",\
     datos using 1:4 with lines ls 3 title "Anillo ({/Symbol a} = {/Symbol p})"


unset multiplot
unset output  # Cerramos el PDF

# =============================================================================
# PANTALLA (Check Rápido)
# =============================================================================
# Terminal wxt para que quede abierta la ventana al ejecutar
set term wxt persist size 900,600 font "Sans,11" 
set title "Vista Rápida en Pantalla: Todas las curvas superpuestas"
set xlabel "Energía (E)"
set ylabel "Transmisión T(E)"
set key top right box

plot datos using 1:2 with lines ls 1 title "DQD Simple", \
     datos using 1:3 with lines ls 2 title "Anillo ({/Symbol a} = 0)", \
     datos using 1:4 with lines ls 3 title "Anillo ({/Symbol a} = {/Symbol p})"