
# Comienza el Ajuste
##############################################

# Definimos la variable independiente ’t’
set dummy t 

# Definimos la función a ajustar
F(t) = A * exp(-t/T) * cos(w*t + phi)   # !Observemos que GNUPlot conoce las funciones exp y cos

# Estimacion inicial de los parámetros
A = 10
w = 2 * pi * 5.5 # Hz    !Observar la cte pi
T = .500 # s
phi = pi/2 # rad

# Realización del Ajuste
# Nuestro conjunto de datos están guardado en el archivo tipo texto llamado "medidas.txt"
fit F(t) "medidas.txt" via A, w, T, phi


# Comienzo del Gráfico
##############################

# Definimos la terminal a utilizar y el nombre del grafico.
set terminal png
set output 'fitGraph.png'


set title "Grafico del Ajuste de una Funcion" tc lt 2

set yrange [-12:12]
set grid

plot "medidas.txt"  w points pt 6 ps 2 title "Mediciones" , F(t) title "Curva de Ajuste"
