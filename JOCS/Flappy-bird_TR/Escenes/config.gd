extends Node2D

@onready var poblacio = $Poblacio/Num
@onready var puntuacio_max = $Puntuacio_max/Num
@onready var generacions = $Generacions/Num
@onready var partides = $Partides/Num

# Called when the node enters the scene tree for the first time.
func _ready():
	poblacio.text = str(Global.num_poblacio)
	puntuacio_max.text = str(Global.puntuacio_max)
	generacions.text = str(Global.num_gen_max)
	partides.text = str(Global.num_partidas)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !poblacio.text.is_valid_int() and !poblacio.text.is_empty():
		poblacio.text = str(poblacio.text.to_int())
	if !puntuacio_max.text.is_valid_int() and !puntuacio_max.text.is_empty():
		puntuacio_max.text = str(puntuacio_max.text.to_int())
	if !generacions.text.is_valid_int() and !generacions.text.is_empty():
		generacions.text = str(generacions.text.to_int())
	if !partides.text.is_valid_int() and !partides.text.is_empty():
		partides.text = str(partides.text.to_int())


func _on_ok_pressed():
	if poblacio.text.to_int() != 0:
		Global.num_poblacio = poblacio.text.to_int()
	if puntuacio_max.text.to_int() != 0:
		Global.puntuacio_max = puntuacio_max.text.to_int()
	if generacions.text.to_int() != 0:
		Global.num_gen_max = generacions.text.to_int()
	if partides.text.to_int() != 0:
		Global.num_partidas = partides.text.to_int()
	get_tree().change_scene_to_file("res://Escenes/inteficie.tscn") # Replace with function body.
