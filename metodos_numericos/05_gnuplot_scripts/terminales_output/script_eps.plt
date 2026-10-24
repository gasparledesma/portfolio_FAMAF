

set terminal postscript eps size 20.0cm, 15.0cm enhanced color font 'Arial,34' linewidth 3
set output 'graph.eps'


set grid lt 1 lw 0 lc rgb "#21172A"

set xrange [-10:10]

# left axis
set format y "%.1tE%1T"    # number with scientific notation
#set ytics 10 mirror tc lt 1   # mirror tells gnuplot to put unlabelled
set ytics 10 nomirror tc lt 1     # tics at the same positions on the opposite
                                 # border. nomirror does what you think it does.
set ylabel '2*x' tc lt 1

# right axis
set y2tics 10 nomirror tc lt 2
set y2label '5*x' tc lt 2


plot 2*x linetype 1, 5*x linetype 2 axes x1y2
