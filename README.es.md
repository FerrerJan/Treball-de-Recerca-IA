# Superando al humano en Flappy Bird 🐦

**Una IA que aprende sola a jugar a Flappy Bird mediante neuroevolución, y un estudio de qué la hace aprender más rápido.**

🌐 [English](README.md) · **Español** · [Català](README.ca.md)

<p align="center">
  <img src="docs/img/gameplay.png" alt="APFLY-IA jugando a Flappy Bird, puntuación 375" height="320">
  &nbsp;&nbsp;
  <img src="docs/img/learning-curve.png" alt="El fitness crece de forma logarítmica con cada generación (R² = 0,92)" height="320">
</p>

Treball de Recerca de Bachillerato (Institució Cultural del CIC, Barcelona, curso 2024–2025), hecho por
**[Marc Pérez Fusco](https://github.com/mapefu)**, **[Jan Ferrer Paramio](https://github.com/FerrerJan)** y **[Teo Clerici Jurado](https://github.com/teo-clerk)**.

Construimos nuestro propio Flappy Bird en **Godot Engine** para usarlo como "laboratorio digital". Dentro vive **APFLY-IA**, una red neuronal de tipo NEAT que programamos desde cero en GDScript. El juego registra cada generación en disco, y unos scripts de Python convierten esos registros en gráficas. En total analizamos **3.798 partidas y más de 450.000 generaciones**.

📄 **[Leer el trabajo (PDF, en catalán)](docs/paper/TR.pdf)** · 🖼️ **[Póster](docs/poster/Poster.pdf)** · 📊 **[Presentación](docs/slides/Presentation.pptx)** · 🕸️ **[Mapa interactivo del proyecto](docs/architecture/)**

## Resultados principales

| Pregunta | Respuesta |
|---|---|
| ¿Cómo es el aprendizaje? | **Logarítmico**: mejora mucho en las primeras generaciones y luego se estanca. El R² medio del ajuste logarítmico es **0,73**, y algunas partidas llegan a **0,97**. |
| ¿Qué inputs funcionan mejor? | Solo la **posición Y del pájaro (PYO)** y la **posición Y del hueco (PYF)**. Si se le dan como un único valor relativo, aprende aún más rápido. Los inputs de más (X del hueco, velocidad) lo frenan. |
| ¿Qué mutación funciona mejor? | La **no estructural** (cambiar los pesos de las conexiones). Las estructurales dan un empujón inicial pero luego se estancan, y el crossover no aporta una mejora clara. |
| ¿Qué población conviene? | **La mayor que aguante tu ordenador.** La mayor que probamos fue 100, y fue la que aprendió más rápido. |
| ¿Cuánto tarda? | Con la configuración adecuada, a partir de la **generación ~8** sale un jugador perfecto. |

## Cómo funciona APFLY-IA

1. Cada **agente** es una red neuronal pequeña. Sus entradas se eligen entre PYO, PYF, PXF y VYO, y tiene una sola salida. Una sigmoide la deja entre 0 y 1, y **si pasa de 0,7, el pájaro salta**.
2. Toda la **población** juega a la vez. Cada agente acumula **fitness**: +1000 por tubo superado, un bonus por volar cerca del centro del hueco, +1 por segundo vivo y −100 si toca el suelo.
3. Cuando han muerto todos los pájaros, o una partida llega a 150 tubos (unos 160.000 de fitness), se guardan los mejores agentes. La siguiente **generación** se crea a partir de ellos copiándolos, cruzándolos (crossover) y mutándolos.
4. Cada generación se guarda en `game/Dades*/`, y los scripts de `analysis/` la convierten en las gráficas y tablas de R² del trabajo.

El diagrama de la arquitectura está en el [README en inglés](README.md#how-apfly-ia-works). Se generó con [graphify](https://github.com/safishamsi/graphify), y también puedes abrir el **[grafo interactivo](https://raw.githack.com/FerrerJan/Treball-de-Recerca-IA/main/docs/architecture/graph.html)**.

## Estructura del repositorio

| Carpeta | Qué contiene |
|---|---|
| [`game/`](game/) | El proyecto de Godot 4.2: el juego, la IA y los menús de configuración. Para empezar, mira [`Scripts/classe_IA.gd`](game/Scripts/classe_IA.gd) (la red neuronal), [`Scripts/PersonatgeIA.gd`](game/Scripts/PersonatgeIA.gd) (el pájaro) y [`Scripts/escena_ia.gd`](game/Scripts/escena_ia.gd) (el bucle de entrenamiento). |
| [`analysis/`](analysis/) | Scripts de Python, gráficas generadas, hojas de R² y conclusiones escritas |
| [`docs/`](docs/) | Entregables finales: trabajo, póster, presentación, figuras y mapa del proyecto |
| [`assets/`](assets/) | Sprites originales de Flappy Bird |
| [`archive/`](archive/) | Borradores, presentaciones individuales, investigación preliminar y datos antiguos |

## Ejecutarlo

1. Instala [Godot 4.2 o superior](https://godotengine.org/download).
2. Importa [`game/project.godot`](game/project.godot) desde el Project Manager y pulsa **F5**.
3. En el menú, configura la población, los inputs y las mutaciones, y empieza el entrenamiento. Teclas: `Esc` vuelve al menú, `R` termina la ronda y `A` aleatoriza las redes. Para jugar tú, abre `Escenes/inici.tscn` y pulsa **F6**.

Para el análisis: `pip install openpyxl` y ejecuta los scripts de [`analysis/scripts/`](analysis/scripts/) desde la raíz del repo.
