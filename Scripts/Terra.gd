extends Area2D

@export var velocitat : float
@export var p : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _process(delta):
	#var desp := Vector2(velocitat,0)*(-1)
	if Global.mort == false:
		var desp := Vector2(velocitat,0)*(-1)
		position += desp
		if Global.iniciat == true:
			Global.distancia += 1


func _on_rotacio_area_entered(area):
	position = Vector2(p,240)
	
