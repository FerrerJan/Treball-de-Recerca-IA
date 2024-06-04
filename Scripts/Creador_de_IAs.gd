extends Node2D

@export var num_IA := 30
@onready var ia = preload("res://Escenes/ia.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(num_IA):
		add_child(ia.instantiate())
