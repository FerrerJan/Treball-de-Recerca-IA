extends Node2D

@onready var container = $VBoxContainer
@onready var conection = preload("res://Escenes/config_connections.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Global.connections.size()):
		container.add_child(conection.instantiate())
		container.get_child(-1).from.text = str(Global.connections[i][0])
		container.get_child(-1).to.text = str(Global.connections[i][1])
		container.get_child(-1).weight.text = str(Global.connections[i][2])
		container.get_child(-1).i = container.get_child_count() - 1
		print('hey')
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_add_pressed():
	container.add_child(conection.instantiate()) 
	container.get_child(-1).i = Global.connections.size()
	Global.connections.append([0, 1, 0])
	container.get_child(-1).from.text = str(Global.connections[container.get_child(-1).i][0])
	container.get_child(-1).to.text = str(Global.connections[container.get_child(-1).i][1])
	container.get_child(-1).weight.text = str(Global.connections[container.get_child(-1).i][2])



func _on_delete_pressed():
	var n := container.get_child_count()
	if n > 0:
		container.get_child(-1).queue_free()
		Global.connections.pop_at(-1)


func _on_ok_pressed():
	get_tree().change_scene_to_file("res://Escenes/config.tscn") # Replace with function body.
