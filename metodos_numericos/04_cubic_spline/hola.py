import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation

# Configuración de los datos
v_max = 20  # Voltaje máximo
puntos = 200
v = np.linspace(0, v_max, puntos)

# Función para simular la curva de Franck-Hertz (picos crecientes)
def franck_hertz_curve(v):
    # Tendencia base ascendente + oscilación senoidal para los valles
    base = 0.5 * v**1.5 
    oscilacion = 5 * (1 + np.sin(2 * np.pi * v / 4.9 - np.pi/2))
    return (base + oscilacion) * (v > 0.5) # Empieza después de un pequeño umbral

i_data = franck_hertz_curve(v)

# Configuración de la figura
fig, ax = plt.subplots(figsize=(8, 5))
line, = ax.plot([], [], 'b-', lw=2, label='Corriente de placa (I)')
punto, = ax.plot([], [], 'ro') # El punto que se mueve

ax.set_xlim(0, v_max)
ax.set_ylim(0, max(i_data) + 10)
ax.set_title('Simulación de la Curva de Franck-Hertz')
ax.set_xlabel('Potencial de aceleración (V)')
ax.set_ylabel('Corriente (nA)')
ax.grid(True, linestyle='--', alpha=0.7)
ax.legend()

# Función de inicialización
def init():
    line.set_data([], [])
    punto.set_data([], [])
    return line, punto

# Función de actualización para la animación
def update(frame):
    x = v[:frame]
    y = i_data[:frame]
    line.set_data(x, y)
    if frame > 0:
        punto.set_data([v[frame-1]], [i_data[frame-1]])
    return line, punto

# Crear la animación
ani = FuncAnimation(fig, update, frames=puntos, init_func=init, blit=True, interval=30)

plt.show()