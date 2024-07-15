extends Node2D

@onready var poblacio = $Poblacio/Num
@onready var puntuacio_max = $Puntuacio_max/Num
@onready var generacions = $Generacions/Num
@onready var partides = $Partides/Num
@onready var terra = $Terra
@onready var velocitat_joc = $VelJoc/VelocitatJoc
var velocitat := 138

# Called when the node enters the scene tree for the first time.
func _ready():
	poblacio.text = str(Global.num_poblacio)
	puntuacio_max.text = str(Global.puntuacio_max)
	generacions.text = str(Global.num_gen_max)
	partides.text = str(Global.num_partidas)
	velocitat_joc.text = str(Global.velocitat_joc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	terra.position[0] += velocitat * (-1) * delta
	if terra.position[0] < 0:
		terra.position[0] = 2245.597
	if !poblacio.text.is_valid_int() and !poblacio.text.is_empty():
		poblacio.text = str(poblacio.text.to_int())
	if !puntuacio_max.text.is_valid_int() and !puntuacio_max.text.is_empty():
		puntuacio_max.text = str(puntuacio_max.text.to_int())
	if !generacions.text.is_valid_int() and !generacions.text.is_empty():
		generacions.text = str(generacions.text.to_int())
	if !partides.text.is_valid_int() and !partides.text.is_empty():
		partides.text = str(partides.text.to_int())
	if !velocitat_joc.text.is_valid_int() and !velocitat_joc.text.is_empty():
		velocitat_joc.text = str(velocitat_joc.text.to_int())


func _on_ok_pressed():
	guardar_dades()
	get_tree().change_scene_to_file("res://Escenes/inteficie.tscn") # Replace with function body.


func _on_inputs_pressed():
	guardar_dades()
	get_tree().change_scene_to_file("res://Escenes/config_inputs.tscn") # Replace with function body.


func _on_mutacions_pressed():
	guardar_dades()
	get_tree().change_scene_to_file("res://Escenes/config_mutacions.tscn") # Replace with function body.


func guardar_dades():
	if not poblacio.text.to_int() <= 0:
		Global.num_poblacio = poblacio.text.to_int()
	if not puntuacio_max.text.to_int() <= 0:
		Global.puntuacio_max = puntuacio_max.text.to_int()
	if not generacions.text.to_int() <= 0:
		Global.num_gen_max = generacions.text.to_int()
	if not partides.text.to_int() <= 0:
		Global.num_partidas = partides.text.to_int()
	if not velocitat_joc.text.to_int() <= 0:
		Global.velocitat_joc = velocitat_joc.text.to_int()
