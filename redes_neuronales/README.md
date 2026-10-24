# Redes Neuronales — FAMAF-UNC

Notebooks de **Python/Jupyter** de la materia **Redes Neuronales** (2026), cubriendo modelos computacionales de neurociencia y redes neuronales artificiales.

---

## 📓 Notebooks

| Archivo | Tema | Librerías |
|---------|------|-----------|
| [`guia04_integracion_odes.ipynb`](./guia04_integracion_odes.ipynb) | Integración numérica de ODEs | NumPy, Matplotlib |
| [`guia05_integrate_and_fire.ipynb`](./guia05_integrate_and_fire.ipynb) | Modelo Integrate and Fire | NumPy, Matplotlib |
| [`guia06_izhikevich.ipynb`](./guia06_izhikevich.ipynb) | Modelo de Izhikevich + Red neuronal SDE | NumPy, Matplotlib |
| [`guia07_lorenz_caos.ipynb`](./guia07_lorenz_caos.ipynb) | Sistema de Lorenz y caos | NumPy, SciPy, Matplotlib |
| [`guia08_hodgkin_huxley.ipynb`](./guia08_hodgkin_huxley.ipynb) | Modelo de Hodgkin-Huxley | NumPy, Matplotlib |
| [`guia09_perceptron.ipynb`](./guia09_perceptron.ipynb) | Perceptrón con PyTorch (OR, XOR) | PyTorch |
| [`guia10_autoencoder.ipynb`](./guia10_autoencoder.ipynb) | Autoencoder con Fashion-MNIST | PyTorch, TorchVision |

---

## 📚 Descripción de cada guía

### Guía 4 — Integración numérica de ODEs
Implementación desde cero de integradores numéricos de Ecuaciones Diferenciales Ordinarias:
- **Método de Euler**: primer orden, $x(t+h) \approx x(t) + f(x,t)h$
- **Runge-Kutta 4 (RK4)**: cuarto orden, mucho más preciso
- Integrador genérico `integrador_ode(m, f, xa, a, b, k, p, c)`
- Aplicaciones: crecimiento exponencial, convergencia, péndulo simple, Lotka-Volterra

### Guía 5 — Modelo Integrate and Fire (IAF)
Modelo de neurona biológica más simple que captura el comportamiento de disparo:
$$\frac{dV}{dt} = \frac{1}{\tau}\left(E - V(t) + R \cdot I(t)\right)$$
Con mecanismo de disparo: $V(t) \to E$ cuando $V(t) > V_u$.
- Solución analítica para $I=0$ y $I=const$
- Análisis geométrico (puntos fijos, campo vectorial)
- Período y frecuencia de disparo vs corriente

### Guía 6 — Modelo de Izhikevich
Modelo bidimensional que reproduce múltiples tipos de comportamiento neuronal:
$$v'(t) = g_2 v^2 + g_1 v + g_0 - u + I(t)$$
$$u'(t) = b(cv - u)$$
- 8 tipos de neuronas: RS, IB, CH, FS, TC1, TC2, RZ, LTS
- Red de 1000 neuronas con dinámica estocástica (Euler-Maruyama)
- Raster plot de spikes

### Guía 7 — Sistema de Lorenz y Caos
Sistema clásico de ecuaciones diferenciales caóticas:
$$\dot{x} = s(y-x), \quad \dot{y} = rx - y - xz, \quad \dot{z} = xy - bz$$
- Tres regímenes dinámicos (estable, periódico, caótico)
- El famoso **Atractor de Lorenz** en 3D
- Mapa de Poincaré (z_{i+1} vs z_i)
- Efecto del ruido y suavizado de señales

### Guía 8 — Modelo de Hodgkin-Huxley
El modelo biofísico completo del potencial de acción neuronal (Premio Nobel 1963):
$$C\dot{v} = i - \bar{g}_{Na} m^3 h (v-v_{Na}) - \bar{g}_K n^4 (v-v_K) - g_l (v-v_l)$$
- Implementación de las 4 ODEs con compuertas ionicas ($n$, $m$, $h$)
- Estímulo débil vs fuerte (umbral de disparo)
- Período refractario
- Exitaciones espontáneas por ruido

### Guía 9 — Perceptrón con PyTorch
Redes neuronales artificiales con PyTorch:
- Perceptrón simple (`nn.Sequential`) entrenado con SGD
- Clasificación binaria OR y XOR
- Por qué XOR **no** es linealmente separable (análisis de la frontera de decisión)
- Red con capa oculta (2→2→1) que sí puede representar XOR

### Guía 10 — Autoencoder con Fashion-MNIST
Red neuronal para compresión no supervisada de imágenes:
- Arquitectura Encoder-Decoder: 784 → 128 → 64 → 32 → 64 → 128 → 784
- Entrenamiento con MSELoss y Adam
- Visualización de reconstrucciones
- Exploración del espacio latente con PCA/t-SNE

---

## 🔧 Requisitos

```bash
pip install numpy scipy matplotlib torch torchvision jupyter
```

## 🚀 Uso

```bash
jupyter notebook guia04_integracion_odes.ipynb
```
