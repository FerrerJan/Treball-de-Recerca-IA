extends Node2D

@export var num_IA := 0
var IA_vives
@onready var ia = preload("res://Escenes/ia.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.num_IA = num_IA

func _process(delta):
	if Global.iniciat == true and Global.Z == 0:
		for i in range(num_IA):
			add_child(ia.instantiate())
		Global.Z += 1 
		
