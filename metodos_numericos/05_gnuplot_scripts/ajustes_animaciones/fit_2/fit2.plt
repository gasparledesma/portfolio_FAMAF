#!/usr/local/bin/gnuplot -persist

# Definimos la variable independiente ’x’
set dummy x 

# Definimos la función a ajustar
l(x) = y0 + m*x + c*x**2 + d*x**3

# Estimacion inicial de los parámetros
y0 = 1.1
m = -0.1
c = 1.0
d = 1.0


# Archivo de datos
fileData = "lcdemo.dat"

fit l(x) fileData via y0, m, c, d

stats fileData using 2

show variables all

#set terminal pngcairo  transparent enhanced fontscale 1.0 size 600, 400 
set terminal pngcairo enhanced fontscale 1.0 size 600, 400 
set output 'fit.1.png'
set key bmargin center horizontal Right noreverse enhanced autotitle nobox
unset parametric
set title "data set and initial parameters" 
set xlabel "Temperature T (Â°C)" 
set xrange [ * : * ] noreverse writeback
set x2range [ * : * ] noreverse writeback
set ylabel "Density (g/cm^3)" 
set yrange [ * : * ] noreverse writeback
set y2range [ * : * ] noreverse writeback
set zrange [ * : * ] noreverse writeback
set cbrange [ * : * ] noreverse writeback
set rrange [ * : * ] noreverse writeback
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault

myencoding = "utf8"

## Last datafile plotted: "lcdemo.dat"
plot fileData, l(x)

