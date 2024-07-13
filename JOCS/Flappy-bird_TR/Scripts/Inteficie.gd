extends Node2D

@onready var terra = $Terra
var velocitat := 138
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.partidas = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	terra.position[0] += velocitat * (-1) * delta
	if terra.position[0] < 0:
		terra.position[0] = 2245.597


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn") # Replace with function body.


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Escenes/config.tscn") # Replace with function body.
