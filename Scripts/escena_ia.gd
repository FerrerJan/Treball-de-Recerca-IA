extends Node2D

@export var escena_obstacle: PackedScene
@export var min : float
@export var max : float
var random_number: float
var posicio: float
var posicio_obstacles = Vector2(0,0)
var Vpos_personatge : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.mort = false
	Global.iniciat = false
	Global.punts = 0
	Global.distancia = 0
	Global.posicio_obstacle = 0
	$resultat.visible = false
	$Contador2.visible = false
	$maxim.visible = false
	Global.I = 0
	posicio = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("espai") and Global.iniciat == false:
		Global.iniciat = true
		$Obstacles/Timer.start()
		$volar_principi/CollisionShape2D.disabled = true
		$clicar.visible = false
		$clicar2.visible = false
	$Contador.text = str(Global.punts)
	$Contador2.text = str(Global.punts)
	$maxim.text = str(Global.maxim)
	if Global.punts > Global.maxim:
		Global.maxim = Global.punts 
	if Global.mort == true:
		$Obstacles/Timer.stop()
		$resultat.visible = true
		$Contador.visible = false
		$Contador2.visible = true
		$maxim.visible = true
	if Input.is_action_just_pressed("enter") and Global.mort == true:
		get_tree().change_scene_to_file("res://Escenes/Escena principal.tscn")
		
	if Global.mort == true and Global.I == 0:
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
	get_tree().change_scene_to_file("res://Escenes/inici.tscn")


func _on_puntuacio_area_exited(area):
	Global.punts += 1
	Global.distancia += 50
	Global.posicio_obstacle_continua = Vector2(1000,1000)
	#print(Global.punts)
