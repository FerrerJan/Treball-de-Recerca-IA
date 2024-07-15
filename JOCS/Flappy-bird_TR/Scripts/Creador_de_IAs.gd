extends Node2D

var num_IA := Global.num_poblacio
var IA_vives
@onready var IA = preload("res://Escenes/ia.tscn")
var xarxa_neuronal_preparada := false
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.num_IA = num_IA
	if Global.gen == 0:
		Global.max_fitness_partida = -1.0
		Global.millor_ocell_partida = ClasseIa.ia.new()
		Global.population = []
		for i in range(num_IA):
			Global.population.append(ClasseIa.ia.new())
		
	else:
		var mostra := int(num_IA * 0.1 + 1)
		var pares := int(mostra * 0.5)
		var millors := []
		var fills := []
		var fitness := []
		if Global.gen % 10 == 0:
			print(Global.gen)
		for i in Global.population:
			fitness.append(i.fitness)
		for _i in range(mostra):
			millors.append(ClasseIa.ia.new())
			millors[_i].copia(Global.population[fitness.find(fitness.max())])
			Global.population.pop_at(fitness.find(fitness.max()))
			fitness.pop_at(fitness.find(fitness.max()))
		for _i in range(pares):
			for _j in range(_i + 1, mostra):
				if millors[_i].mateixa_especie(millors[_j]) and Global.mutacions.find(2) != -1:
					fills.append(ClasseIa.ia.new())
					fills[-1].crossover(millors[_i], millors[_j])
		Global.population = [] + millors + fills
		var numero_inicial_de_IAs := len(Global.population)
		for _i in range(numero_inicial_de_IAs, num_IA):
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var r := rng.randi_range(0, mostra - 1)
			Global.population.append(ClasseIa.ia.new())
			Global.population[_i].copia(Global.population[r])
			#for _j in range(rng.randi_range(0, 5)):
			Global.population[_i].mutar(Global.population[r])
	Global.gen += 1
	xarxa_neuronal_preparada = true
	

func _process(delta):
	if Global.iniciat == true and Global.Z == 0 and xarxa_neuronal_preparada:
		for i in range(num_IA):
			add_child(IA.instantiate())
			get_child(i).p = i
			get_child(i).inici()
		Global.Z += 1 
