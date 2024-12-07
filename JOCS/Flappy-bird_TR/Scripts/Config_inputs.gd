extends Node2D

@onready var terra = $Terra
@onready var PosYOcellPosYObs = $VBoxContainer/PosYOcellPosYObs/CheckButton
@onready var PosYOcellPosYMon = $VBoxContainer/PosYOcellPosYMon/CheckButton
@onready var PosYOcell = $VBoxContainer/PosYOcell/CheckButton
@onready var PosYObs = $VBoxContainer/PosYObs/CheckButton
@onready var PosXObs = $VBoxContainer/PosXObs/CheckButton
@onready var VelYOcell = $VBoxContainer/VelYOcell/CheckButton
@onready var PosYMonedes = $VBoxContainer/PosYMonedes/CheckButton
var velocitat := 138
var inputs := Global.inputs
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in inputs:
		if i == 0:
			PosYOcellPosYObs.button_pressed = true
		elif i == 1:
			PosYOcellPosYMon.button_pressed = true
		elif i == 2:
			PosYOcell.button_pressed = true
		elif i == 3:
			PosYObs.button_pressed = true
		elif i == 4:
			PosXObs.button_pressed = true
		elif i == 5:
			VelYOcell.button_pressed = true
		elif i == 6:
			PosYMonedes.button_pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	terra.position[0] += velocitat * (-1) * delta
	if terra.position[0] < 0:
		terra.position[0] = 2245.597


func _on_ok_pressed():
	Global.inputs = []
	if PosYOcellPosYObs.button_pressed == true:
		Global.inputs.append(0)
	if PosYOcellPosYMon.button_pressed == true:
		Global.inputs.append(1)
	if PosYOcell.button_pressed == true:
		Global.inputs.append(2)
	if PosYObs.button_pressed == true:
		Global.inputs.append(3)
	if PosXObs.button_pressed == true:
		Global.inputs.append(4)
	if VelYOcell.button_pressed == true:
		Global.inputs.append(5)
	if PosYMonedes.button_pressed == true:
		Global.inputs.append(6)
	if Global.inputs.size() == 0:
		Global.inputs = inputs
	get_tree().change_scene_to_file("res://Escenes/config.tscn") # Replace with function body.
