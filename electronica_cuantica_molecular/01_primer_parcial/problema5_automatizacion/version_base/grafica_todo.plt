reset

# =============================================================================
# CONFIGURACIÓN GENERAL
# =============================================================================
set grid
set xrange [-4:4]

# Estilos de Línea
set style line 1 lc rgb "red" lw 2      
set style line 2 lc rgb "blue" lw 2     
set style line 3 lc rgb "dark-violet" lw 2 
set style line 4 lc rgb "forest-green" lw 2   
set style line 5 lc rgb "dark-orange" lw 2
set style line 6 lc rgb "dark-cyan" lw 2

# Archivo de datos (25 columnas)
# Mapa de columnas:
# Col  1: E
# Q=2/a  W=0.5:  2=DOS  3=N(E)  4=T   5=delta
# Q=2/a  W=2.0:  6=DOS  7=N(E)  8=T   9=delta
# Q=2/a  W=3.0: 10=DOS 11=N(E) 12=T  13=delta
# Q=2pi/3a W=0.5: 14=DOS 15=N(E) 16=T  17=delta
# Q=2pi/3a W=2.0: 18=DOS 19=N(E) 20=T  21=delta
# Q=2pi/3a W=3.0: 22=DOS 23=N(E) 24=T  25=delta
datos = "datos/todos_los_datos.dat"

# =============================================================================
# PDF 1: DENSIDAD DE ESTADOS (DOS) - Escala Automática
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "graficos/Resultados_DOS.pdf"

set multiplot layout 3,2 title "Densidad de Estados (DOS): Modelo de Hofstadter" font ",14"

set autoscale y 
set yrange [*:*] 

# --- FILA 1: W = 0.5 ---
set title "Q = 2/a, W = 0.5"
set ylabel "DOS (u.a.)"
set xlabel ""
plot datos using 1:2 with lines ls 3 title "DOS"

set title "Q = 2{/Symbol p}/3a, W = 0.5"
set ylabel ""
plot datos using 1:14 with lines ls 4 title "DOS"

# --- FILA 2: W = 2.0 ---
set title "Q = 2/a, W = 2.0"
set ylabel "DOS (u.a.)"
plot datos using 1:6 with lines ls 3 title "DOS"

set title "Q = 2{/Symbol p}/3a, W = 2.0"
set ylabel ""
plot datos using 1:18 with lines ls 4 title "DOS"

# --- FILA 3: W = 3.0 ---
set title "Q = 2/a, W = 3.0"
set ylabel "DOS (u.a.)"
set xlabel "Energía (E)"
plot datos using 1:10 with lines ls 3 title "DOS"

set title "Q = 2{/Symbol p}/3a, W = 3.0"
set ylabel ""
set xlabel "Energía (E)"
plot datos using 1:22 with lines ls 4 title "DOS"

unset multiplot
unset output

# =============================================================================
# PDF 2: TRANSMISIÓN T(E) (Rango fijo 0 a 1.1)
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "graficos/Resultados_Transmision.pdf"

set multiplot layout 3,2 title "Transmisión Electrónica T(E): Modelo de Hofstadter" font ",14"

set yrange [0:1.1]

# --- FILA 1: W = 0.5 ---
set title "Q = 2/a, W = 0.5"
set ylabel "Transmisión T(E)"
set xlabel "" 
plot datos using 1:4 with lines ls 1 title "T(E)"

set title "Q = 2{/Symbol p}/3a, W = 0.5"
set ylabel ""
plot datos using 1:16 with lines ls 2 title "T(E)"

# --- FILA 2: W = 2.0 ---
set title "Q = 2/a, W = 2.0"
set ylabel "Transmisión T(E)"
plot datos using 1:8 with lines ls 1 title "T(E)"

set title "Q = 2{/Symbol p}/3a, W = 2.0"
set ylabel ""
plot datos using 1:20 with lines ls 2 title "T(E)"

# --- FILA 3: W = 3.0 ---
set title "Q = 2/a, W = 3.0"
set ylabel "Transmisión T(E)"
set xlabel "Energía (E)"
plot datos using 1:12 with lines ls 1 title "T(E)"

set title "Q = 2{/Symbol p}/3a, W = 3.0"
set ylabel ""
set xlabel "Energía (E)"
plot datos using 1:24 with lines ls 2 title "T(E)"

unset multiplot
unset output

# =============================================================================
# PDF 3: DENSIDAD ACUMULADA DE ESTADOS N(E)
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "graficos/Resultados_N_E.pdf"

set multiplot layout 3,2 title "Densidad Acumulada de Estados N(E): Modelo de Hofstadter" font ",14"

set autoscale y
set yrange [*:*]

# --- FILA 1: W = 0.5 ---
set title "Q = 2/a, W = 0.5"
set ylabel "N(E)"
set xlabel ""
plot datos using 1:3 with lines ls 5 title "N(E)"

set title "Q = 2{/Symbol p}/3a, W = 0.5"
set ylabel ""
plot datos using 1:15 with lines ls 6 title "N(E)"

# --- FILA 2: W = 2.0 ---
set title "Q = 2/a, W = 2.0"
set ylabel "N(E)"
plot datos using 1:7 with lines ls 5 title "N(E)"

set title "Q = 2{/Symbol p}/3a, W = 2.0"
set ylabel ""
plot datos using 1:19 with lines ls 6 title "N(E)"

# --- FILA 3: W = 3.0 ---
set title "Q = 2/a, W = 3.0"
set ylabel "N(E)"
set xlabel "Energía (E)"
plot datos using 1:11 with lines ls 5 title "N(E)"

set title "Q = 2{/Symbol p}/3a, W = 3.0"
set ylabel ""
set xlabel "Energía (E)"
plot datos using 1:23 with lines ls 6 title "N(E)"

unset multiplot
unset output

# =============================================================================
# PDF 4: INVERSA DE LA LONGITUD DE LOCALIZACIÓN δ(E) = 1/ξ
# =============================================================================
set terminal pdfcairo enhanced font 'Sans,10' size 8in,10in
set output "graficos/Resultados_Localizacion.pdf"

set multiplot layout 3,2 title "Inversa de la Longitud de Localización {/Symbol d}(E) = -ln(T)/2N" font ",14"

set autoscale y
set yrange [0:*]

# --- FILA 1: W = 0.5 ---
set title "Q = 2/a, W = 0.5"
set ylabel "{/Symbol d}(E) = 1/{/Symbol x}"
set xlabel ""
plot datos using 1:5 with lines ls 1 title "{/Symbol d}(E)"

set title "Q = 2{/Symbol p}/3a, W = 0.5"
set ylabel ""
plot datos using 1:17 with lines ls 2 title "{/Symbol d}(E)"

# --- FILA 2: W = 2.0 ---
set title "Q = 2/a, W = 2.0"
set ylabel "{/Symbol d}(E) = 1/{/Symbol x}"
plot datos using 1:9 with lines ls 1 title "{/Symbol d}(E)"

set title "Q = 2{/Symbol p}/3a, W = 2.0"
set ylabel ""
plot datos using 1:21 with lines ls 2 title "{/Symbol d}(E)"

# --- FILA 3: W = 3.0 ---
set title "Q = 2/a, W = 3.0"
set ylabel "{/Symbol d}(E) = 1/{/Symbol x}"
set xlabel "Energía (E)"
plot datos using 1:13 with lines ls 1 title "{/Symbol d}(E)"

set title "Q = 2{/Symbol p}/3a, W = 3.0"
set ylabel ""
set xlabel "Energía (E)"
plot datos using 1:25 with lines ls 2 title "{/Symbol d}(E)"

unset multiplot
unset output

# =============================================================================
# PANTALLA (Check Rápido - Caso W=2.0)
# =============================================================================
set term wxt persist size 1200,700 font "Sans,10"
set multiplot layout 2,2 title "Vista Rápida (Q=2/a, W=2.0)"

set autoscale y
set title "DOS"
plot datos using 1:6 with lines ls 3 title "DOS"

set yrange [0:1.1]
set title "Transmisión"
plot datos using 1:8 with lines ls 1 title "T(E)"

set autoscale y
set yrange [*:*]
set title "N(E) Acumulada"
plot datos using 1:7 with lines ls 5 title "N(E)"

set yrange [0:*]
set title "{/Symbol d}(E) = 1/{/Symbol x}"
plot datos using 1:9 with lines ls 1 title "{/Symbol d}(E)"

unset multiplot