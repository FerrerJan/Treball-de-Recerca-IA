extends Node2D

@export var escena_obstacle: PackedScene
@export var min : float = -150
@export var max : float = 130
var random_number: float
var posicio: float
var posicio_obstacles = Vector2(0,0)
var Vpos_personatge : Vector2
@onready var collision = $CollisionShape2D
var activat := false
var repetir_escena_enable := true


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
	
	 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Global.gen)
	if !Global.mort:
		var fitness := []
		for i in Global.population:
				fitness.append(i.fitness)
		Global.max_fitness_index = fitness.find(fitness.max())
		print(Global.max_fitness_index)
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
		
	if Global.mort:
		if Global.repetir == false:
			$Obstacles/Timer.stop()
			$resultat.visible = true
			$Contador.visible = false
			$Contador2.visible = true
			$maxim.visible = true
		elif repetir_escena_enable:
			print('time starts')
			repetir_escena_enable = false
			$Repetir_escena.start()
			
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
		
func _on_timer_timeout():
	if Global.iniciat == true:
		$Obstacles/Timer.start()
		crea_obstacle(posicio_obstacles)
		random_number = randi_range(min, max)
	else:
		$Obstacles/Timer.stop()
	
func crea_obstacle(posicio: Vector2):
	var nou_obstacle = escena_obstacle.instantiate()
	nou_obstacle.global_position = posicio + Vector2(0,random_number)
	$Obstacles.add_child(nou_obstacle)


func _on_puntuacio_area_entered(area):
	Global.distancia += 5


func _on_obsacles_eliminar_area_entered(area):
	area.queue_free()
	#print('eliminat')


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")


func _on_puntuacio_area_exited(area):
	Global.punts += 1
	Global.distancia += 50
	Global.posicio_obstacle_continua = Vector2(490, 300)
	#print(Global.punts)


func _on_repetir_escena_timeout():
	print('time out')
	get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
