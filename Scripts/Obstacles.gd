extends Node2D

@export var velocitat : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.mort == false:
		var desp := Vector2(velocitat,0)*(-1)
		position += desp


func _on_body_entered(body):
	Global.mort = true
	print('a')
