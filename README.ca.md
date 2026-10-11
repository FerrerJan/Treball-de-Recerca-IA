# Superant l'Humà en "Flappy Bird" 🐦

**Un estudi sobre l'aprenentatge automàtic: una IA que aprèn sola a jugar a Flappy Bird per neuroevolució.**

🌐 [English](README.md) · [Español](README.es.md) · **Català**

<p align="center">
  <img src="docs/img/gameplay.png" alt="L'APFLY-IA jugant a Flappy Bird, puntuació 375" height="320">
  &nbsp;&nbsp;
  <img src="docs/img/learning-curve.png" alt="El fitness creix de forma logarítmica amb les generacions (R² = 0,92)" height="320">
</p>

Treball de Recerca de Batxillerat (Institució Cultural del CIC, Barcelona, curs 2024–2025), fet per
**[Marc Pérez Fusco](https://github.com/mapefu)**, **[Jan Ferrer Paramio](https://github.com/FerrerJan)** i **[Teo Clerici Jurado](https://github.com/teo-clerk)**.

Hem construït un Flappy Bird propi amb **Godot Engine** que fa de laboratori digital. Hi viu l'**APFLY-IA** (*Autonomous Player Fast Learning Yeld*), una xarxa neuronal de tipus NEAT programada des de zero en GDScript. El joc registra cada generació, i els scripts de Python en fan les gràfiques. En total hem analitzat **3.798 partides i més de 450.000 generacions**.

📄 **[Treball escrit (PDF)](docs/paper/TR.pdf)** · 🖼️ **[Pòster](docs/poster/Poster.pdf)** · 📊 **[Presentació](docs/slides/Presentation.pptx)** · 🕸️ **[Mapa interactiu del projecte](docs/architecture/)**

## Conclusions

- L'aprenentatge és **logarítmic**: R² mitjà de **0,73** i fins a **0,97** en algunes partides.
- Els millors inputs són la **posició Y de l'ocell (PYO)** i la **posició Y del forat (PYF)**, i encara millor si es donen relacionats en un sol valor. Si se li dona informació innecessària, l'aprenentatge s'alenteix.
- La millor mutació és la **no estructural** (canviar el pes de les connexions).
- Com **més població**, més ràpid aprèn. La més alta que hem provat és 100.
- Amb la configuració correcta, a partir de la **8a generació** sempre s'obté una IA perfecta.

## Estructura

| Carpeta | Contingut |
|---|---|
| [`game/`](game/) | Projecte de Godot 4.2: el joc, la IA i els menús de configuració |
| [`analysis/`](analysis/) | Scripts de Python, gràfiques, taules de R² i conclusions |
| [`docs/`](docs/) | Treball, pòster, presentació, figures i mapa del projecte |
| [`assets/`](assets/) | Sprites originals de Flappy Bird |
| [`archive/`](archive/) | Esborranys, presentacions individuals, recerca preliminar i dades antigues |

Per executar-lo: obre [`game/project.godot`](game/project.godot) amb Godot 4.2 o superior i prem **F5**. Trobaràs més detalls al [README en anglès](README.md#run-it-yourself).
