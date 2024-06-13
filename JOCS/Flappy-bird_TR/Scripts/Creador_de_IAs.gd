extends Node2D

@export var num_IA := 0
var IA_vives
@onready var IA = preload("res://Escenes/ia.tscn")
var train_enable := true
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.num_IA = num_IA
	for i in range(num_IA):
		Global.population.append(ClasseIa.ia.new())

func _process(delta):
	if Global.iniciat == true and Global.Z == 0:
		for i in range(num_IA):
			add_child(IA.instantiate())
			get_child(i).p = i
		Global.Z += 1 
	if Global.mort and train_enable:
		train_enable = !train_enable
		var mostra := int(num_IA * 0.1 + 1)
		var millors := []
		var fitness := []
		for i in Global.population:
			fitness.append(i.fitness)
		for _i in range(mostra):
			millors.append(ClasseIa.ia.new())
			millors[_i].copia(Global.population[fitness.find(fitness.max())])
			Global.population.pop_at(fitness.find(fitness.max()))
			fitness.pop_at(fitness.find(fitness.max()))
		Global.population = [] + millors
		for _i in range(mostra, num_IA):
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			var r := rng.randi_range(0, mostra - 1)
			Global.population.append(ClasseIa.ia.new())
			Global.population[_i].copia(Global.population[r])
			Global.population[_i].mutar()
			print('m')

			
			
	elif !Global.mort and !train_enable:
		train_enable = !train_enable
