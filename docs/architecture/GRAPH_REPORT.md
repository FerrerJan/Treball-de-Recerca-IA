# Graph Report - graph-corpus  (2026-10-11)

## Corpus Check
- Corpus is ~7,113 words - fits in a single context window. You may not need a graph.

## Summary
- 230 nodes · 361 edges · 31 communities (12 shown, 19 thin omitted)
- Extraction: 80% EXTRACTED · 20% INFERRED · 0% AMBIGUOUS · INFERRED: 73 edges (avg confidence: 0.86)
- Token cost: 167,791 input · 0 output

## Community Hubs (Navigation)
- Neural Network & Play Loop
- NEAT Prototype & Settings
- Findings: Inputs
- Findings: Mutations & Population
- Training Scene & Data Logging
- Python Data Pipeline
- Menus & Scene Flow
- Manual Network Editor
- R2 Analysis Script
- Obstacle Spawning
- Menu Ground Scroll
- Coin Spawning
- Human Play Restart
- AnimationPlayer.gd
- AnimationPlayer._process
- automatitzacio.gd
- Button.gd
- config.gd
- Config_inputs.gd
- config_mutacions.gd
- config_xarxa_neuronal.gd
- escena_ia._on_tdelay_timeout
- Escena principal.gd
- Inteficie.gd
- Inteficie._on_ok_pressed (quit)
- Personatge.gd
- PersonatgeIA._on_area_2d_body_entered
- Prova.gd
- Prova._ready (Array.find test)
- Terra.gd
- Terra._on_rotacio_area_entered

## God Nodes (most connected - your core abstractions)
1. `escena_ia._process (round/generation control)` - 23 edges
2. `Superant l'Humà en Flappy Bird (Treball de Recerca)` - 17 edges
3. `Creador_de_IAs._ready (build generation)` - 16 edges
4. `NEAT (Neuro Evolution of Augmenting Topologies)` - 12 edges
5. `APFLY-IA (Autonomous Player Fast Learning Yeld)` - 10 edges
6. `Taula de R² mitjans per inputs × mutacions` - 10 edges
7. `classe_IA.gd (autoload ClasseIa)` - 9 edges
8. `ia.mutar()` - 9 edges
9. `config.guardar_dades()` - 9 edges
10. `Input PYF (posició Y del centre del forat de l'obstacle)` - 9 edges

## Surprising Connections (you probably didn't know these)
- `XarxaNeuronal.gd (NEAT prototype)` --semantically_similar_to--> `Xarxa neuronal (Input/Hidden/Output, pesos -1..1)`  [INFERRED] [semantically similar]
  game/NEAT/XarxaNeuronal.gd.txt → docs/paper/TR.pdf
- `Input 0 (PYO) sol: fitness aleatori 0-4.000` --semantically_similar_to--> `Anàlisi dels inputs`  [INFERRED] [semantically similar]
  analysis/conclusions/Conclusions_inputs.txt → docs/paper/TR.pdf
- `R² màxim 0,9739; mitjana 0,731106 (gràfiques amb aprenentatge)` --semantically_similar_to--> `Taula de R² mitjans per inputs × mutacions`  [INFERRED] [semantically similar]
  analysis/conclusions/Conclusió_grafiques.txt → docs/paper/TR.pdf
- `Hipòtesi: input 0/1 (relació entre PYO i PYF)` --semantically_similar_to--> `Input combinat PYO/PYF (diferència)`  [INFERRED] [semantically similar]
  analysis/conclusions/Conclusions_inputs.txt → docs/paper/TR.pdf
- `Hipòtesi: input 0/1 (relació entre PYO i PYF)` --semantically_similar_to--> `Importància relativa dels pesos (Exemple d'una IA perfecte)`  [INFERRED] [semantically similar]
  analysis/conclusions/Conclusions_inputs.txt → docs/paper/TR.pdf

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Neuroevolution generation cycle (spawn, evaluate fitness, select, crossover, mutate)** — game_scripts_creador_de_ias_gd_ready, game_scripts_creador_de_ias_gd_process, game_scripts_personatgeia_gd_physics_process, game_scripts_personatgeia_gd_actualizar_fitness, game_scripts_classe_ia_gd_ia_feedforward, game_scripts_classe_ia_gd_ia_copia, game_scripts_classe_ia_gd_ia_mateixa_especie, game_scripts_classe_ia_gd_ia_crossover, game_scripts_classe_ia_gd_ia_mutar, game_scripts_escena_ia_gd_process, game_scripts_global_gd_population [INFERRED 0.95]
- **Training results persistence pipeline (buffers in Global, written to Dades / DadesExcel / Dades_Json)** — game_scripts_escena_ia_gd_guardar_dades_gen, game_scripts_escena_ia_gd_guardar_dades_partida, game_scripts_escena_ia_gd_guardar_dades_arxiu, game_scripts_escena_ia_gd_desa_arxiu, game_scripts_escena_ia_gd_desa_dades, game_scripts_escena_ia_gd_desa_json, game_scripts_global_gd_dades, game_dades_results_txt, game_dadesexcel_py_results_txt, game_dades_json_results_json [EXTRACTED 1.00]
- **AI configuration menu flow writing Global settings** — game_scripts_config_gd_guardar_dades, game_scripts_config_inputs_gd_on_ok_pressed, game_scripts_config_mutacions_gd_on_button_pressed, game_scripts_config_mutacions_gd_guardar_dades, game_scripts_config_xarxa_neuronal_gd_on_ok_pressed, game_scripts_config_connections_gd_process, game_escenes_config_tscn, game_escenes_config_inputs_tscn, game_escenes_config_mutacions_tscn, game_escenes_config_xarxa_neuronal_tscn, game_scripts_global_gd_inputs, game_scripts_global_gd_mutacions, game_scripts_global_gd_connections [INFERRED 0.85]
- **NEAT evolution operators (selection, MNE, ME, Crossover)** — docs_paper_tr_neat, docs_paper_tr_seleccio_10_percent, docs_paper_tr_mutacio_no_estructural_mne, docs_paper_tr_mutacio_estructural_me, docs_paper_tr_crossover_crs [EXTRACTED 1.00]
- **APFLY-IA candidate input variables** — docs_paper_tr_input_pyo, docs_paper_tr_input_pyf, docs_paper_tr_input_pxf, docs_paper_tr_input_vyo [EXTRACTED 1.00]
- **Optimal fast-learning configuration (PYO-PYF, MNE, high population)** — docs_paper_tr_conclusio, analysis_conclusions_conclusions_inputs_input_0_1_pyo_pyf, analysis_conclusions_conclusions_mutacions_mutacio_0_no_estructural, analysis_conclusions_conclusions_poblaci__mes_poblacio_aprenentatge_rapid [INFERRED 0.85]

## Communities (31 total, 19 thin omitted)

### Community 0 - "Neural Network & Play Loop"
Cohesion: 0.09
Nodes (39): Escena principal.tscn (human play scene), ia.tscn (AI bird instance), Input action enter (restart), Input action espai (space/click: flap, start), Button._on_pressed, ia.feedforward(), ia.sigmoid(), ia.valor() (+31 more)

### Community 1 - "NEAT Prototype & Settings"
Cohesion: 0.09
Nodes (36): config.tscn (settings menu), NEATConnection (prototype), NEATIndividual (prototype), NEATIndividual.crossover(), NEATIndividual.mutate(), NEATNeuron (prototype), XarxaNeuronal._process (evolution loop), XarxaNeuronal._ready (+28 more)

### Community 2 - "Findings: Inputs"
Cohesion: 0.13
Nodes (33): R² màxim 0,9739; mitjana 0,731106 (gràfiques amb aprenentatge), Hipòtesi: input 0/1 (relació entre PYO i PYF), Inputs 0-1-2-3 (tots): combinació menys eficaç amb info suficient, Inputs 0-1-2 (PYO-PYF-PXF): més lent que 0-1, millor que 0-1-3, Inputs 0-1-3 (PYO-PYF-VYO): aprenentatge alentit, Inputs 0-1 (PYO-PYF): aprenentatge més ràpid, Input 0 (PYO) sol: fitness aleatori 0-4.000, Input 1 (PYF) sol: no pot passar cap obstacle (+25 more)

### Community 3 - "Findings: Mutations & Population"
Cohesion: 0.13
Nodes (25): Mutació 0 (no estructural): fitness més alt i estable, Mutació 1 (estructural): valors dispersos, fitness més baix, Mutació 2 (crossover): sense canvis notables; dispersió en 20% dels casos amb mutació 0, Més població per generació → aprenentatge més ràpid, Agent (xarxa neuronal individual), Constants experimentals (20-30 partides, 125 generacions, max 150 tubs), Anàlisi de les mutacions, Anàlisi de les poblacions (+17 more)

### Community 4 - "Training Scene & Data Logging"
Cohesion: 0.13
Nodes (18): Dades_Json/<nom>_<n>.json (structured results), Dades/<nom>_<n>.txt (human-readable run report), DadesExcel/PY_<nom>_<n>.txt (fitness series for Python), escena_ia.tscn (AI training scene), Input action Esc (back to menu), Input action R (force end of round), Input action Xarxa_aleatoria (key A: randomize networks), escena_ia.desa_arxiu() (+10 more)

### Community 5 - "Python Data Pipeline"
Cohesion: 0.14
Nodes (8): NEATConnection, NEATIndividual, NEATNeuron, json, openpyxl, os, random, re

### Community 6 - "Menus & Scene Flow"
Cohesion: 0.13
Nodes (15): config_inputs.tscn, config_mutacions.tscn, config_xarxa_neuronal.tscn, inteficie.tscn (main menu, main scene), project.godot, config.guardar_dades(), config._on_inputs_pressed, config._on_mutacions_pressed (+7 more)

### Community 7 - "Manual Network Editor"
Cohesion: 0.38
Nodes (7): config_connections.tscn (connection row), config_connections.gd, config_connections._process (sync row to Global.connections), config_xarxa_neuronal._on_add_pressed, config_xarxa_neuronal._on_delete_pressed, config_xarxa_neuronal._ready, Global.connections (manual NN connections)

### Community 8 - "R2 Analysis Script"
Cohesion: 0.60
Nodes (4): filter_and_calculate(), main(), parse_txt_file(), pathlib

### Community 9 - "Obstacle Spawning"
Cohesion: 0.40
Nodes (5): escena_ia.crea_obstacle(), escena_ia._on_timer_timeout, EscenaPrincipal.crea_obstacle(), EscenaPrincipal._on_timer_timeout, Obstacles.gd

### Community 10 - "Menu Ground Scroll"
Cohesion: 0.50
Nodes (4): config._process, Config_inputs._process (ground scroll), config_mutacions._process (ground scroll), Inteficie._process (ground scroll)

### Community 11 - "Coin Spawning"
Cohesion: 0.67
Nodes (3): escena_ia.crea_moneda(), escena_ia._on_tmoneda_timeout, moneda.gd

## Ambiguous Edges - Review These
- `XarxaNeuronal.gd (NEAT prototype)` → `classe_IA.gd (autoload ClasseIa)`  [AMBIGUOUS]
  game/NEAT/XarxaNeuronal.gd.txt · relation: conceptually_related_to

## Knowledge Gaps
- **56 isolated node(s):** `AnimationPlayer.gd`, `Button.gd`, `Config_inputs.gd`, `Escena principal.gd`, `Global.gd (autoload Global)` (+51 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 69 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **19 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `XarxaNeuronal.gd (NEAT prototype)` and `classe_IA.gd (autoload ClasseIa)`?**
  _Edge tagged AMBIGUOUS (relation: conceptually_related_to) - confidence is low._
- **Why does `classe_IA.gd (autoload ClasseIa)` connect `Findings: Mutations & Population` to `NEAT Prototype & Settings`, `Menus & Scene Flow`?**
  _High betweenness centrality (0.211) - this node is a cross-community bridge._
- **Why does `Creador_de_IAs._ready (build generation)` connect `NEAT Prototype & Settings` to `Neural Network & Play Loop`, `Training Scene & Data Logging`, `Menus & Scene Flow`?**
  _High betweenness centrality (0.196) - this node is a cross-community bridge._
- **Why does `class ia (neural network genome)` connect `NEAT Prototype & Settings` to `Findings: Mutations & Population`?**
  _High betweenness centrality (0.183) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `escena_ia._process (round/generation control)` (e.g. with `ia.copia()` and `ia.xarxa_aleatoria()`) actually correct?**
  _`escena_ia._process (round/generation control)` has 3 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `Creador_de_IAs._ready (build generation)` (e.g. with `XarxaNeuronal._process (evolution loop)` and `escena_ia._process (round/generation control)`) actually correct?**
  _`Creador_de_IAs._ready (build generation)` has 2 INFERRED edges - model-reasoned connections that need verification._
- **Are the 2 inferred relationships involving `NEAT (Neuro Evolution of Augmenting Topologies)` (e.g. with `neat-python (McIntyre et al., 2024)` and `classe_IA.gd (autoload ClasseIa)`) actually correct?**
  _`NEAT (Neuro Evolution of Augmenting Topologies)` has 2 INFERRED edges - model-reasoned connections that need verification._