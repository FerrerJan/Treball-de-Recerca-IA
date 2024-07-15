extends Node2D

@onready var terra = $Terra
@onready var PosYOcell = $PosYOcell/CheckButton
@onready var PosYObs = $PosYObs/CheckButton
@onready var PosXObs = $PosXObs/CheckButton
@onready var VelYOcell = $VelYOcell/CheckButton
var velocitat := 138
var inputs := Global.inputs
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in inputs:
		if i == 0:
			PosYOcell.button_pressed = true
		elif i == 1:
			PosYObs.button_pressed = true
		elif i == 2:
			PosXObs.button_pressed = true
		elif i == 3:
			VelYOcell.button_pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	terra.position[0] += velocitat * (-1) * delta
	if terra.position[0] < 0:
		terra.position[0] = 2245.597


func _on_ok_pressed():
	Global.inputs = []
	if PosYOcell.button_pressed == true:
		Global.inputs.append(0)
	if PosYObs.button_pressed == true:
		Global.inputs.append(1)
	if PosXObs.button_pressed == true:
		Global.inputs.append(2)
	if VelYOcell.button_pressed == true:
		Global.inputs.append(3)
	if Global.inputs.size() == 0:
		Global.inputs = inputs
	get_tree().change_scene_to_file("res://Escenes/config.tscn") # Replace with function body.
