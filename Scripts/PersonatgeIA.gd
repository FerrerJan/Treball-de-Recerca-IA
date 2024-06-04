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


func _ready():
	for _i in range(num_inputs):  # 3 neuronas de entrada
		neurons.append(NEATNeuron.new())
	for _i in range(num_hidden):  # 2 neuronas ocultas
		neurons.append(NEATNeuron.new())
	for _i in range(num_outputs):  # 1 neurona de salida
		neurons.append(NEATNeuron.new())
	for _i in range(3 * 2 + 2 * 1):  # Conexiones entre neuronas
		connections.append(NEATConnection.new())
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for _i in range(3 * 2 + 2 * 1):
		connections[_i].from_neuron = rng.randi() % 3
		connections[_i].to_neuron = rng.randi() % (3 + 2 + 1)
		connections[_i].weight = rng.randf() * 2 - 1

func _physics_process(delta):
	if Global.mort == false:
		var inputs := [get_global_position().y, Global.posicio_obstacle_continua[0], Global.posicio_obstacle_continua[1]] 
		if not is_on_floor():
			velocity.y += gravity * delta
		if feedforward(inputs)[0] > 0.5:
			velocity.y = JUMP_VELOCITY
		if Global.life == true:
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
	for i in range(num_inputs):
		neurons[i].output = inputs[i]
	for i in range(num_hidden):
		neurons[num_inputs + i].output = sigmoid(neurons[num_inputs + i].output * connections[i].weight)
	for i in range(num_outputs):
		neurons[num_inputs + num_hidden + i].output = sigmoid(neurons[num_inputs + num_hidden + i].output * connections[num_hidden + i].weight)
	for i in range(num_outputs):
		outputs.append(neurons[num_inputs + num_hidden + i].output)
	return outputs

func sigmoid(x):
	return 1 / (1 + exp(-x))

