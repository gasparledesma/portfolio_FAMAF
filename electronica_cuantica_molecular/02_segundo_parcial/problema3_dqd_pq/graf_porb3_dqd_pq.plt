reset

# =============================================================================
# CONFIGURACIÓN GENERAL
# =============================================================================
set grid
set xrange [-4.5:4.5]
set yrange [-1.2:1.2]

# Estilos de Línea
set style line 1 lc rgb "black" lw 2             # Coherente (Gam=0)
set style line 2 lc rgb "purple" lw 2            # Total Media (Gam=0.5)
set style line 3 lc rgb "red" lw 2               # Total Fuerte (Gam=2.0)
set style line 4 lc rgb "blue" dt 2 lw 2         # T_coh (en Fuerte)
set style line 5 lc rgb "green" dt 4 lw 2        # T_inc (en Fuerte)

datos = "datos/dqd_dp_exacto.dat"

# =============================================================================
# PDF: DESTRUCCIÓN DE LA ANTIRESONANCIA POR DECOHERENCIA
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "graficos/Resultados_Prob3_Definitivo.pdf"

set multiplot layout 2,1 title "Problema 3: Modelo DP Multieterminal Exacto" font ",16"

# --- PANEL 1: Destrucción del Valle de Antiresonancia ---
set title "1. Relleno de la Antiresonancia por Decoherencia (Flujo {/Symbol a} = {/Symbol p})" font ",12"
set ylabel "Transmitancia Efectiva T_{eff}"
set xlabel "Energía (E)" 
set key top right box
plot datos using 1:2 with lines ls 1 title "Coherente ({/Symbol G}_{/Symbol f} = 0.0)", \
     datos using 1:3 with lines ls 2 title "Media ({/Symbol G}_{/Symbol f} = 0.5)", \
     datos using 1:6 with lines ls 3 title "Fuerte ({/Symbol G}_{/Symbol f} = 2.0)"

# --- PANEL 2: Desglose en el régimen de Decoherencia Fuerte ---
set title "2. Desglose de Canales para Decoherencia Fuerte ({/Symbol G}_{/Symbol f} = 2.0)" font ",12"
set ylabel "Transmitancia"
set xlabel "Energía (E)" 
set key top right box
plot datos using 1:7 with lines ls 4 title "T_{coh} (Supervivientes - Interferencia residual)", \
     datos using 1:8 with lines ls 5 title "T_{inc} (Difusivos - Rellenan el valle)", \
     datos using 1:6 with lines ls 3 title "T_{eff} (Total medible)"

unset multiplot
unset output

# =============================================================================
# PANTALLA (Check Rápido)
# =============================================================================
set term wxt persist size 900,600 font "Sans,11" 
set title "Destrucción de la Antiresonancia Cuántica"
set xlabel "Energía (E)"
set ylabel "Transmitancia Efectiva T_{eff}"
set key top right box

plot datos using 1:2 with lines ls 1 title "Coherente ({/Symbol G}_{/Symbol f} = 0)", \
     datos using 1:3 with lines ls 2 title "Media ({/Symbol G}_{/Symbol f} = 0.5)", \
     datos using 1:6 with lines ls 3 title "Fuerte ({/Symbol G}_{/Symbol f} = 2.0)"