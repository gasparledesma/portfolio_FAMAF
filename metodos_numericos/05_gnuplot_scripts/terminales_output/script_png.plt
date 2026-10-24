
set terminal png
set output 'graph.png'

set grid lt 1 lw 0 lc rgb "#21172A"

set format y "%.1tE%1T"    # number with scientific notation
set xrange [-10:10]

# left axis
set ytics 10 nomirror tc lt 1
set ylabel '2*x' tc lt 1

# right axis
set y2tics 20 nomirror tc lt 2
set y2label '5*x' tc lt 2


plot 2*x linetype 1, 5*x linetype 2 axes x1y2
