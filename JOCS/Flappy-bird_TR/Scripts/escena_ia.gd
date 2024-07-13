extends Node2D

@export var escena_obstacle: PackedScene
@export var min : float = -145
@export var max : float = 126

var num_generacions : int = 0
var max_puntuacio : int = 0
var num_ia : int = 0
var num_joc : int = 0 

var random_number: float
var posicio: float
var posicio_obstacles = Vector2(0,0)
var Vpos_personatge : Vector2
@onready var collision = $CollisionShape2D
var activat := false

var dades : String
# var document =

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.mort = false
	Global.iniciat = false
	Global.Z = 1
	Global.punts = 0
	Global.distancia = 0
	Global.posicio_obstacle = 0
	$resultat.visible = false
	$Contador2.visible = false
	$maxim.visible = false
	Global.I = 0
	posicio = 0
	Global.morts_ia = 0
	Global.posicio_obstacle_continua = Vector2(490, 207)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Global.gen)
	if !Global.mort:
		var fitness := []
		for i in Global.population:
				fitness.append(i.fitness)
		Global.max_fitness_gen = fitness.max()
		if Global.max_fitness_partida < fitness.max():
			Global.max_fitness_partida = fitness.max()
			Global.millor_ocell_partida.copia(Global.population[fitness.find(fitness.max())])
		Global.max_fitness_index = fitness.find(fitness.max())
		#print(fitness)
	if Global.repetir == true and Global.iniciat == false:
		Global.iniciat = true
		$Obstacles/Timer.start()
		$volar_principi/CollisionShape2D.disabled = true
		$clicar.visible = false
		$clicar2.visible = false
		
		if Global.IA == true:
			$CharacterBody2D.queue_free()
			Global.Z = 0
		
	if Input.is_action_just_pressed("espai") and Global.iniciat == false:
		Global.iniciat = true
		$Obstacles/Timer.start()
		$volar_principi/CollisionShape2D.disabled = true
		$clicar.visible = false
		$clicar2.visible = false
		
		if Global.IA == true:
			$CharacterBody2D.queue_free()
			Global.Z = 0
			
	if Global.morts_ia >= Global.num_IA and Global.IA == true:
		
		Global.mort = true
		
	#print(str(Global.morts_ia)+' / '+str(Global.num_IA) )
	
	$Contador.text = str(Global.punts)
	$Contador2.text = str(Global.punts)
	$maxim.text = str(Global.maxim)
	
	if Global.punts > Global.maxim:
		Global.maxim = Global.punts 
	
	if Global.punts >= Global.puntuacio_max:
		Global.mort = true
			
	if Input.is_action_just_pressed("enter") and Global.mort == true:
		get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
	
	if Global.mort == true and Global.I == 0 and Global.IA == false:
		posicio = $CharacterBody2D.get_global_position().y
		Global.I += 1
		print('')
		print('-------------------------------------------------')
		print('Distancia recorreguda: ' + str(Global.distancia))
		print('Punts: ' + str(Global.punts))
		print('Altura personatge: ' + str(posicio))
		print('Altura del forat: '+ str(Global.posicio_obstacle))
		print('-------------------------------------------------')
		print('')
	
	
	if Input.is_action_just_pressed("I"):
		Global.IA = !Global.IA
		Global.noIA = !Global.noIA
		get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
	
	if Input.is_action_just_pressed("R"):
		Global.mort = true
		
	if Input.is_action_just_pressed("Xarxa_aleatoria"): #Tecla 'A'
		for ia in Global.population:
			ia.xarxa_aleatoria()
			
	if Input.is_action_just_pressed("K"):
		Global.repetir = !Global.repetir
		#get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
	
	if Global.mort:
		guardar_dades_gen()
		
		if Global.gen >= Global.num_gen_max:
			Global.gen = 0
			Global.partidas += 1
			
		if Global.partidas >= Global.num_partidas:
			get_tree().change_scene_to_file("res://Escenes/inteficie.tscn")
			desa_arxiu()
			
		elif Global.repetir == false:
			$Obstacles/Timer.stop()
			$resultat.visible = true
			$Contador.visible = false
			$Contador2.visible = true
			$maxim.visible = true
		else:
			get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
		
func _on_timer_timeout():
	if Global.iniciat == true:
		$Obstacles/Timer.start()
		random_number = randi_range(min, max)
		crea_obstacle(posicio_obstacles)
	else:
		$Obstacles/Timer.stop()
	
func crea_obstacle(posicio: Vector2):
	var nou_obstacle = escena_obstacle.instantiate()
	nou_obstacle.global_position = posicio + Vector2(0, random_number)
	$Obstacles.add_child(nou_obstacle)

'''
func _on_puntuacio_area_entered(area):
	Global.population[area.p].fitness += 200.0
'''

func _on_obsacles_eliminar_area_entered(area):
	area.queue_free()
	#print('eliminat')


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")


func _on_puntuacio_area_exited(area):
	Global.punts += 1
	for i in range($Creador_de_IAs.get_child_count()):
		Global.population[$Creador_de_IAs.get_child(i).p].fitness += 1000.0
	#Global.population[get_parent().area.p].fitness += 1000.0
	Global.posicio_obstacle_continua[0] = 490
	#print(Global.punts)
	
func guardar_dades_gen():
	'''
	Global.max_fitness_gen
	Global.gen
	'''
	
	dades += 'dades_gen' + ';' + str(Global.max_fitness_gen) + ';' + str(Global.gen) + '\n'
	
func guardar_dades_partida():
	'''
	Global.partidas
	Global.max_fitness_partida
	Global.millor_ocell_partida
	'''
	
	dades += 'dades_partida' + ';' + str(Global.partidas) + ';' + str(Global.max_fitness_partida) + ';' + str(Global.millor_ocell_partida) + '\n'
	
func guardar_dades_arxiu():
	'''
	Global.inputs
	Global.num_poblacio
	Global.num_gen_max
	Global.puntuacio_max
	Global.num_partidas
	'''
	dades += 'dades_arxiu' + ';' + str(Global.inputs) + ';' + str(Global.num_poblacio) + ';' + str(Global.num_gen_max) + ';' + str(Global.puntuacio_max) + ';' + str(Global.num_partidas) + '\n'
	
func desa_arxiu():

	var file_name = "res://dades/jan.txt" # Cambia això per la ruta i nom que desitgis
	var content = "Les dades que vols guardar\n"  # El contingut que vols escriure al fitxer

	# Crea o obre el fitxer
	var file = FileAccess.open(file_name, FileAccess.WRITE_READ)
	
	# Mou el punter de l'arxiu al final del fitxer
	file.seek_end()
	
	# Escriu les dades al fitxer
	file.store_string(dades)
	
	# Tanca el fitxer
	file.close()
	print("Dades guardades correctament.")

	
