# Project map (knowledge graph)

This folder holds a knowledge graph of the project, built with [graphify](https://github.com/safishamsi/graphify). The graph covers the GDScript game and AI code, the Python analysis scripts, the written conclusions and the paper.

- **[Open the interactive graph](https://raw.githack.com/FerrerJan/Treball-de-Recerca-IA/main/docs/architecture/graph.html)**. GitHub shows HTML files as source, so this link serves the file through raw.githack. You can also download [`graph.html`](graph.html) and open it locally.
- **[GRAPH_REPORT.md](GRAPH_REPORT.md)** is a plain-language summary of the graph: its core nodes, its communities and its cross-links between the code and the paper.
- **[graph.json](graph.json)** is the raw graph, with 230 nodes and 361 edges.

## What the communities mean

| Community | What it groups |
|---|---|
| Neural Network & Play Loop | `classe_IA.gd` (feedforward, sigmoid) and the bird agent `PersonatgeIA.gd` |
| Training Scene & Data Logging | `escena_ia.gd`: rounds, generations and writing logs to `Dades*/` |
| Menus & Scene Flow / Manual Network Editor | The settings menus that write population, inputs, mutations and connections to `Global.gd` |
| NEAT Prototype & Settings | The first prototype in `game/NEAT/` (not used by the final game) |
| Python Data Pipeline / R2 Analysis Script | `analysis/scripts/` |
| Findings: Inputs / Findings: Mutations & Population | The concepts and conclusions from the paper, linked to the code that implements them |

## Notes on how the graph was made

- graphify has no GDScript parser, so the `.gd` scripts were given to its semantic extractor as text. That is why source paths in the graph end in `.gd.txt`.
- Edges are tagged `EXTRACTED` when they come straight from the source (calls, scene changes, Global reads and writes) and `INFERRED` when the model judged the connection. Two examples of INFERRED edges: calls dispatched dynamically across Godot nodes, and links between a paper concept and the code that implements it.
- The raw data logs in `game/Dades*/` were left out of the graph.
