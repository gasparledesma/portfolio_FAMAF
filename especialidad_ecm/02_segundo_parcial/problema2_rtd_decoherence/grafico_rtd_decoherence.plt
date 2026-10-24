reset

# =============================================================================
# CONFIGURACIÓN GENERAL
# =============================================================================
set grid
set xrange [-5.0:5.0]

# Fijamos Y para la Transmisión (probabilidad va de 0 a 1)
set yrange [-0.05:1.05]

# Estilos de Línea
# ls 1: Puramente coherente (Negro)
set style line 1 lc rgb "black" lw 2      
# ls 2: Transmitancia Efectiva con Decoherencia Media (Violeta)
set style line 2 lc rgb "purple" lw 2             
# ls 3: Transmitancia Efectiva con Decoherencia Fuerte (Rojo)
set style line 3 lc rgb "red" lw 2              
# ls 4: Transmitancia Puramente Coherente (Azul punteado)
set style line 4 lc rgb "blue" dt 2 lw 2
# ls 5: Transmitancia Incoherente (Verde punteado)
set style line 5 lc rgb "green" dt 4 lw 2

# Archivo de datos (Asegúrate de que el nombre coincida con la salida de Fortran)
datos = "datos/rtd_transmittance.dat"

# =============================================================================
# PDF: TRANSMISIÓN RTD Y MODELO D'AMATO-PASTAWSKI
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "graficos/Resultados_DP_Decoherencia.pdf"

set multiplot layout 2,1 title "Modelo D'Amato-Pastawski: RTD con Decoherencia" font ",16"

# --- PANEL 1: Conservación del Área ---
set title "1. Conservación del Área en el Transporte (Transmitancia Efectiva)" font ",12"
set ylabel "Transmitancia Efectiva T_{eff}"
set xlabel "Energía (E)" 
set key top right box
plot datos using 1:2 with lines ls 1 title "Coherente ({/Symbol G}_{/Symbol f} = 0.0)", \
     datos using 1:3 with lines ls 2 title "Media ({/Symbol G}_{/Symbol f} = 0.5)", \
     datos using 1:6 with lines ls 3 title "Fuerte ({/Symbol G}_{/Symbol f} = 2.0)"

# --- PANEL 2: Desglose de Canales Coherente e Incoherente ---
set title "2. Desglose de Transmitancias para Decoherencia Fuerte ({/Symbol G}_{/Symbol f} = 2.0)" font ",12"
set ylabel "Transmitancia"
set xlabel "Energía (E)" 
set key top right box
plot datos using 1:7 with lines ls 4 title "T_{coh} (Sobrevivientes)", \
     datos using 1:8 with lines ls 5 title "T_{inc} (Difusivos)", \
     datos using 1:6 with lines ls 3 title "T_{eff} (Total)"

unset multiplot
unset output  # Cerramos el PDF

# =============================================================================
# PANTALLA (Check Rápido)
# =============================================================================
# Terminal wxt para que quede abierta la ventana al ejecutar
set term wxt persist size 900,600 font "Sans,11" 
set title "Conservación del Área en el Transporte (Transmitancia Efectiva)"
set xlabel "Energía (E)"
set ylabel "Transmitancia Efectiva T_{eff}"
set key top right box

plot datos using 1:2 with lines ls 1 title "Coherente ({/Symbol G}_{/Symbol f} = 0.0)", \
     datos using 1:3 with lines ls 2 title "Media ({/Symbol G}_{/Symbol f} = 0.5)", \
     datos using 1:6 with lines ls 3 title "Fuerte ({/Symbol G}_{/Symbol f} = 2.0)"