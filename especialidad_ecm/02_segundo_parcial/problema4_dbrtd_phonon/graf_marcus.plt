reset
set terminal pdfcairo enhanced font 'Sans,12' size 6in,4in
set output "graficos/Resultados_Prob4b_Marcus.pdf"

set title "Inciso (b): Transferencia Electrónica de Marcus-Hush" font ",14"
set xlabel "Fuerza Impulsora / Diferencia de Energía (E_A - E_B) [eV]"
set ylabel "Constante Cinética k_{A->B} (u.a.)"
set grid

# Parámetros físicos
V_AB = 0.05      # Acoplamiento electrónico
Delta = 1.0      # Energía de reorganización (Corrimiento Polarónico)
kT = 0.025       # Energía térmica a temperatura ambiente (~300K)
pi = 3.14159265

# Fórmula analítica de Marcus (Regla de Oro de Fermi a alta T)
k(x) = (2*pi * V_AB**2) * (1.0 / sqrt(4 * pi * Delta * kT)) * exp(-(x - Delta)**2 / (4 * Delta * kT))

set xrange [-0.5 : 2.5]
set yrange [0 : *]

# Línea vertical para marcar la Energía de Reorganización
set arrow from Delta, 0 to Delta, k(Delta) nohead lc rgb "gray" dt 2

plot k(x) with lines lc rgb "blue" lw 3 title "Tasa de Transferencia k_{A->B}"

unset output