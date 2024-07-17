extends Node

var life := true
var Obstacles := Node2D
var punts : int = 0
var iniciat = false
var distancia : int = 0
var mort := false
var maxim : int = 0
var I : int
var posicio_obstacle: float
var posicio_obstacle_continua: Vector2 = Vector2(490, 207)
var posicio_personatge_obstacles : Vector2
var Z : int = 0
var IA := true
var noIA := false
var num_IA : int = 0
var morts_ia: int = 0
var population := []
var repetir := true
var max_fitness_index: int = 0 
var gen_seguides_amb_puntuació_maxima :int = 0
var velocitat_joc := 5


#Variables que es guarden per cada arxiu (Després de canviar la config)
var inputs := [0, 1]
var mutacions := [0, 1, 2]
var num_poblacio : int = 25
var num_gen_max : int = 125
var puntuacio_max : int= 150
var num_partidas : int = 30

#Variables que es guarden per cada partida
var partidas : int = 0
var max_fitness_partida := -1.0
var millor_ocell_partida

#Variables que es guarden per cada generació
var max_fitness_gen := -1.0
var gen := 0


var dades : String = ''
var dades_PY : String = ''
var nom : String = ('Població:' + str(num_poblacio) + '_Inputs:' + str(inputs) + '_Mutacions:' + str(mutacions)).replace(' ', '')
var num := 0
var dades_json : = ''
var dades_gen_json : = ''

