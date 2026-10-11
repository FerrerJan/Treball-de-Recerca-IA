extends Area2D

@export var velocitat : float
@export var p : float
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.mort = false



func _process(delta):
	delta *= Global.velocitat_joc
	#var desp := Vector2(velocitat,0)*(-1)
	if Global.mort == false:
		var desp := Vector2(velocitat,0)*(-1)
		position += desp * delta
		if Global.iniciat == true:
			Global.distancia += 1


func _on_rotacio_area_entered(area):
	position = Vector2(p,240)
	



func _on_body_entered(body):
	if Global.IA == true:
		Global.morts_ia += 1
		#print(body.get_global_position().x)
		body.queue_free()
	
	else:
		Global.mort = true

