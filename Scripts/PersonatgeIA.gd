extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var animacio = 0

var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/1.4


var neurons = []
var connections = []
var fitness = 0.0
var num_inputs = 3
var num_hidden = 2
var num_outputs = 1
var mort := false
var life := true


func _ready():
	$CollisionShape2D.disabled = false
	for _i in range(num_inputs):  # 3 neuronas de entrada
		neurons.append(NEATNeuron.new())
	for _i in range(num_hidden):  # 2 neuronas ocultas
		neurons.append(NEATNeuron.new())
	for _i in range(num_outputs):  # 1 neurona de salida
		neurons.append(NEATNeuron.new())
	for _i in range(num_inputs * num_hidden + num_hidden * num_outputs):  # Conexiones entre neuronas
		connections.append(NEATConnection.new())
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index := 0
	for _i in range(num_inputs):
		for _j in range(num_hidden):
			connections[index].from_neuron = _i
			connections[index].to_neuron = num_inputs + _j
			connections[index].weight = rng.randf()
			index += 1
	for _j in range(num_hidden):
		connections[index].from_neuron = _j
		connections[index].to_neuron = num_inputs + num_hidden
		connections[index].weight = rng.randf()
		index += 1

func _physics_process(delta):
	if mort == false:
		var inputs := [get_global_position().y / 5000, Global.posicio_obstacle_continua[0] / 5000, Global.posicio_obstacle_continua[1] / 5000] 
		if not is_on_floor():
			velocity.y += gravity * delta
		if feedforward(inputs)[0] > 0.6:
			velocity.y = JUMP_VELOCITY
		if life == true:
			if velocity.y < 0:
				$AnimatedSprite2D.play()
				set_rotation(deg_to_rad(velocity.y * 0.05))
			elif velocity.y > 0: 
				set_rotation(deg_to_rad(velocity.y * 0.15))
				$AnimatedSprite2D.stop()
			else:
				$AnimatedSprite2D.play()
				set_rotation(0)
			
			move_and_collide(velocity * delta)
		else:
			$AnimatedSprite2D.stop()
	else:
		if not is_on_floor():
			velocity.y += gravity * delta * 2
		else:
			velocity = Vector2(-200, 0)
		$AnimatedSprite2D.stop()
		if animacio == 0 and velocity.y > 0:
			$AnimationPlayer.play('rotacio')
			animacio += 1
	move_and_slide()

class NEATNeuron:
	var output = 0.0

	func __init__():
		pass


class NEATConnection:
	var from_neuron = 0
	var to_neuron = 0
	var weight = 0.0

	func __init__():
		pass

func feedforward(inputs):
	var outputs = []
	for _i in range(num_inputs):
		neurons[_i].output = inputs[_i]
	for _j in range(num_hidden):
		var value := 0
		for _i in range(num_inputs):
			value += neurons[_i].output * connections[_j + num_hidden * _i].weight
		neurons[num_inputs + _j].output = sigmoid(value)
	
	for _j in range(num_outputs):
		var value := 0
		for _i in range(num_hidden):
			value += neurons[num_inputs + _i].output * connections[num_inputs * num_hidden + num_outputs * _i + _j].weight
			#print(neurons[num_inputs + _i].output,' - ', connections[num_inputs * num_hidden + num_outputs * _i + _j].weight)
			print(value , ' - ' , sigmoid(value))
		neurons[num_inputs + num_hidden + _j].output = sigmoid(value)
	for _i in range(num_outputs):
		outputs.append(neurons[num_inputs + num_hidden + _i].output)
	#print(outputs)
	return outputs

func sigmoid(x):
	return 1 / (1 + exp(-x))




'''
func _on_area_2d_area_entered(area):
	gravity = 0 # Replace with function body.
	SPEED = -200
'''

func _on_area_2d_body_entered(body):
	mort = true
