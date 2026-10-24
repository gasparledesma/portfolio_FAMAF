# Electrónica Cuántica Molecular (ECM) — FAMAF-UNC

Trabajos prácticos y parciales de la materia **Electrónica Cuántica Molecular**, implementados en **Fortran 90** con visualización en **GNUplot**.

La materia aborda el estudio numérico de sistemas cuánticos de baja dimensionalidad: función de Green, transporte cuántico, densidad de estados y sistemas oscilatorios acoplados.

---

## 📄 Consignas de Parciales

- [`consignas_parcial1.pdf`](./consignas_parcial1.pdf) — Consignas del 1er Parcial (ECM 2025)
- [`consignas_parcial2.pdf`](./consignas_parcial2.pdf) — Consignas del 2do Parcial (ECM 2025)

---

## 📂 Contenido

### [`01_primer_parcial/`](./01_primer_parcial/)
Problemas del Primer Parcial de ECM. Cada subcarpeta contiene el código Fortran y los scripts de visualización.

#### `problema1_densidad_estados/` — Mapas y gráficos de densidad de estados
Scripts GNUplot para visualizar la densidad de estados, curvas de nivel y mapas de "piano de sincronización".

#### `problema2_ldos/` — Local Density of States (LDOS)
Cálculo de la densidad de estados local para sistemas de cadenas cuánticas, incluyendo:
- `ldos-definidos.f90`: LDOS para parámetros específicos
- `ldos-generico.f90`: LDOS genérico parametrizable
- `selft-energy.f90`: Cálculo de la self-energy del sistema

#### `problema3_estado_resonante/` — Estado resonante
Análisis de estados resonantes en estructuras de barreras cuánticas mediante la función de Green.

#### `problema4_transmision/` — Transmisión cuántica
Cálculo de la transmitancia a través de una barrera cuántica usando el formalismo de Landauer-Büttiker.

#### `problema5_automatizacion/` — Problema más complejo: **3 enfoques**
El Problema 5 fue resuelto de tres maneras distintas, mostrando la riqueza del enfoque numérico:

| Subcarpeta | Enfoque | Descripción |
|------------|---------|-------------|
| `version_base/` | Iterativa directa | Implementación estándar del loop de integración |
| `version_recursiva/` | Relaciones de recursión | Usa la estructura recursiva de la función de Green |
| `version_matricial/` | Álgebra lineal | Formula el problema como inversión matricial |

---

### [`02_segundo_parcial/`](./02_segundo_parcial/)
Problemas del Segundo Parcial. Focalizado en transporte cuántico con el formalismo de Keldysh/NEGF (Non-Equilibrium Green's Functions).

#### `problema1_dqd/` — Double Quantum Dot (DQD) con Tight-Binding
Cálculo de la transmisión en un sistema de doble punto cuántico (DQD) usando el modelo de tight-binding y el método de decimación.

#### `problema2_rtd_decoherence/` — RTD con Decoherencia
Resonant Tunneling Diode con efectos de decoherencia cuántica (modelo de D'Amato-Pastawski-Wirth).

#### `problema3_dqd_pq/` — DQD con Perturbación Cuántica
Sistema DQD con acoplamiento al modelo de perturbación cuántica (modelo exacto).

#### `problema4_dbrtd_phonon/` — DBRTD con Fonones
Double Barrier Resonant Tunneling Diode (DBRTD) con acoplamiento fonónico (modelo de Fock-Phonon). Incluye análisis de la corriente Marcus.

---

### [`03_green_functions/`](./03_green_functions/)
Implementaciones de la **Función de Green** para sistemas cuánticos de cadena finita.

| Archivo | Descripción |
|---------|-------------|
| `chat.f90` | Función de Green de una cadena lineal (modelo tight-binding) |
| `funcGreen.f90` | Módulo de funciones de Green |
| `prueba.f90` | Programa de prueba para funciones de Green |
| `int.f90` / `intento.f90` | Versiones de integración del espectro |
| `N-OrbAtom.f90` | Sistema de N orbitales atómicos |
| `plot_green.plt` | Visualización del espectro de Green |

---

### [`04_pendulos/`](./04_pendulos/)
Scripts GNUplot para el análisis de sistemas de péndulos acoplados. Estos scripts grafican la solución obtenida por integración numérica (Runge-Kutta) de las ecuaciones de movimiento.

| Subcarpeta | Sistema | Descripción |
|------------|---------|-------------|
| `1_pendulo/` | 1 péndulo | Diagramas D vs ω, gráficos de resonancia |
| `2_pendulos/` | 2 péndulos acoplados | Frecuencias normales, energía, acoplamiento |
| `3_pendulos/` | 3 péndulos acoplados | Densidad espectral, frecuencias de acoplamiento |
| `N_pendulos/` | N péndulos (cadena) | Función de Green, imagen de Green, N orbitales |

**Conceptos físicos:** Modos normales de vibración, cadenas de osciladores, densidad espectral, analogía con sistemas cuánticos.

---

### [`05_orbitales/`](./05_orbitales/)
Scripts GNUplot para la visualización de 3 orbitales atómicos acoplados.

---

## 🔧 Compilación

Los programas Fortran usan módulos. El orden de compilación importa:

```bash
# Ejemplo genérico - ver cada carpeta para los módulos específicos
gfortran -o programa modulos/mod-isoprec.f90 modulos/mod-functions.f90 programa.f90
./programa
```

## 📊 Formalismo

Los programas implementan el formalismo de **funciones de Green en equilibrio y fuera del equilibrio (NEGF)**:

$$G^r(E) = [E \cdot I - H - \Sigma^r]^{-1}$$

donde $H$ es el Hamiltoniano del sistema y $\Sigma^r$ es la self-energy de los electrodos.

La transmitancia se calcula mediante la fórmula de Caroli:

$$T(E) = \text{Tr}[\Gamma_L \, G^r \, \Gamma_R \, G^a]$$
