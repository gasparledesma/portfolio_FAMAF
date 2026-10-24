# Métodos Numéricos — FAMAF-UNC

Trabajos prácticos de la materia **Métodos Numéricos** implementados en **Fortran 90** con visualización usando **GNUplot**.

---

## 📂 Contenido

### [`01_aproximacion_raices/`](./01_aproximacion_raices/)
Implementación de los principales métodos de aproximación de raíces de ecuaciones no lineales.

| Archivo | Descripción |
|---------|-------------|
| `programa.f90` | Programa principal que usa todos los métodos |
| `script_comp.sh` | Script de compilación con gfortran |
| `modulos/mod_metodos.f90` | Módulo: bisección, Newton, Regula Falsi, Secante |
| `modulos/mod_funciones.f90` | Módulo: funciones de prueba |
| `modulos/mod_isoprec.f90` | Módulo: precisión ISO Fortran |

**Métodos implementados:**
- **Bisección**: convergencia garantizada, O(1/2^n)
- **Newton-Raphson**: convergencia cuadrática
- **Regula Falsi**: convergencia superlineal
- **Secante**: no requiere derivada analítica

---

### [`02_interpolacion_lagrange_newton/`](./02_interpolacion_lagrange_newton/)
Métodos de interpolación polinomial y subroutinas de Lagrange y Newton.

| Subcarpeta | Descripción |
|------------|-------------|
| `problema1/` | Interpolación básica |
| `guia2_metodos_raices/` | Métodos de bisección y Newton aplicados a problemas específicos |
| `subrutinas_lagrange_newton/` | Subrutinas de interpolación de Lagrange y Newton |

---

### [`03_integracion_numerica/`](./03_integracion_numerica/)
Métodos de integración numérica para funciones analíticas y datos discretos.

| Subcarpeta | Descripción |
|------------|-------------|
| `Problema3/` | Reglas de Trapecio y Simpson (comparación de errores) |
| `Problema4/` | Integración FHIP (Forced Harmonic Integral Problem) |
| `Problema5/` | Integración de funciones exponenciales |

**Métodos implementados:** Trapecio, Simpson 1/3, Simpson 3/8, reglas compuestas.

---

### [`04_cubic_spline/`](./04_cubic_spline/)
Interpolación con splines cúbicos — una de las técnicas más usadas en análisis numérico.

| Archivo | Descripción |
|---------|-------------|
| `MODcubicScplie.f90` | Módulo Fortran del algoritmo de Cubic Spline |
| `testCubicSpline.f90` | Programa de prueba |
| `LeeCubicSpline.plt` | Script GNUplot para visualizar el spline |
| `hola.py` | Implementación Python de referencia |
| `datosIn_b.dat` | Datos de entrada de prueba |

---

### [`05_gnuplot_scripts/`](./05_gnuplot_scripts/)
Colección de scripts de **GNUplot** para visualización científica.

| Subcarpeta | Descripción |
|------------|-------------|
| `guia1_basicos/` | Scripts básicos de GNUplot (líneas, puntos, estilos) |
| `terminales_output/` | Exportar gráficos a JPG, PNG y EPS |
| `ajustes_animaciones/fit_1/` | Ajuste de curvas por mínimos cuadrados |
| `ajustes_animaciones/fit_2/` | Ajuste con funciones más complejas |
| `ajustes_animaciones/animacion/` | Animaciones con GNUplot (función de Bessel) |

---

### [`06_parciales/`](./06_parciales/)
Código del **Primer Parcial** de Métodos Numéricos.

| Archivo | Descripción |
|---------|-------------|
| `parcial1.f90` | Programa principal del parcial |
| `mcd.f90` / `p1-mcd.f90` | Problema 1: MCD y algoritmos relacionados |
| `p2-*.plt` | Scripts GNUplot para el Problema 2 (análisis de convergencia) |
| `modulos/` | Módulos de métodos y funciones |

---

## 🔧 Compilación

Los programas Fortran se compilan con `gfortran`. Ejemplo:

```bash
gfortran -o programa modulos/mod_isoprec.f90 modulos/mod_funciones.f90 modulos/mod_metodos.f90 programa.f90
./programa
```

Para compilar con el script incluido:
```bash
bash script_comp.sh
```

## 📊 Visualización

Los gráficos se generan con **GNUplot**:
```bash
gnuplot script.plt
```
