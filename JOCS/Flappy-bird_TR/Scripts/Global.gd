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
var repetir := false
var max_fitness_index: int = 0 
var gen := 0


#Variables per la configuració de la IA
var inputs := [0, 1]
var num_poblacio := 20
var num_gen_max := 50
var puntuacio_max := 100
var num_partidas := 10
