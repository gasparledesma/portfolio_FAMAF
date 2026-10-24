set term wxt persist
set xlabel "Energía (t)"
set ylabel "Green function"
set grid

plot "green.dat" using 1:3 with lines lw 2 title "Im[G]"
