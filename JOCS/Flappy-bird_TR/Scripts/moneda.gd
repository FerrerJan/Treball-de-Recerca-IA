extends Area2D

@export var velocitat : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta *= Global.velocitat_joc
	if Global.mort == false:
		var desp := Vector2(velocitat,0) * (-1)
		position += desp * delta
		if get_global_position().x > 30 and get_global_position().x < Global.posicio_obstacle_continua.x:
			Global.posicio_moneda_continua = get_global_position()


func _on_body_entered(body):
	if Global.IA == true:
		body.moneda()
	else:
		Global.mort = true
		if Global.I == 0:
			Global.posicio_obstacle = get_global_position().y
