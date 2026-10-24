
# Comienza el Ajuste
##############################################

# Definimos la variable independiente ’t’
set dummy t 

# Definimos la función a ajustar
F(t) = A * exp(-t/T)  # !Observemos que GNUPlot conoce las funciones exp y cos

# Estimacion inicial de los parámetros
A = 100
T = 4 # 

# Archivo de datos
fileData = "decaimiento.txt"
fileGraf = "fitDecaimiento.png"

# Realización del Ajuste
# Nuestro conjunto de datos están guardado en el archivo tipo texto llamado "decaimiento.txt"
fit F(t) fileData via A, T


# Comienzo del Gráfico
##############################

# Definimos la terminal a utilizar y el nombre del grafico.
set terminal png
set output fileGraf

set title "Grafico del Ajuste del Decaimiento" tc lt 2
set label 'valores reales de T = 1.8, A = 6.5 ' at 5,2.3
set yrange [0:7]
set grid

plot fileData  w points pt 6 ps 2 title "Mediciones", F(t) title "Curva de Ajuste"



