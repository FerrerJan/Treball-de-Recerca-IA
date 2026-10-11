extends Node2D

@onready var terra = $Terra
@onready var MutEst = $MutEst/CheckButton
@onready var MutNoEst = $MutNoEst/CheckButton
@onready var Crossover = $Crossover/CheckButton
@onready var mut = $mut/text
var velocitat := 138
var mutacions := Global.mutacions
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in mutacions:
		if i == 1:
			MutEst.button_pressed = true
		elif i == 0:
			MutNoEst.button_pressed = true
		elif i == 2:
			Crossover.button_pressed = true
	
	mut.text = str(Global.num_mutacions)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	terra.position[0] += velocitat * (-1) * delta
	if terra.position[0] < 0:
		terra.position[0] = 2245.597
	
	if !mut.text.is_valid_int() and !mut.text.is_empty():
		mut.text = str(mut.text.to_int())
	

func _on_button_pressed():
	Global.mutacions = []
	if MutEst.button_pressed == true:
		Global.mutacions.append(1)
	if MutNoEst.button_pressed == true:
		Global.mutacions.append(0)
	if Crossover.button_pressed == true:
		Global.mutacions.append(2)
	if Global.mutacions.size() == 0:
		Global.mutacions = mutacions
	guardar_dades()
	
	get_tree().change_scene_to_file("res://Escenes/config.tscn") # Replace with function body.

func guardar_dades():
	if not mut.text.to_int() <= 0:
		Global.num_mutacions = mut.text.to_int()
