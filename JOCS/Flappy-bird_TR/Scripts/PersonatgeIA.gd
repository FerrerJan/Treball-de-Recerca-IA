extends CharacterBody2D

# Constantes
const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var animacio = 0

# Constantes de gravedad y velocidad
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/1.4

# Variables para la red neuronal artificial
var neurons = []
var connections = []
var fitness := 0.0
var num_inputs = 3
var num_hidden = 2
var num_outputs = 1
var mort := false
var life := true
var p := 0

#Classes necesarias para la red neuronal
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

func _ready():
	# Inicialización de la escena
	# Creación de neuronas de entrada, ocultas y salida
	for _i in range(num_inputs):  # 3 neuronas de entrada
		neurons.append(NEATNeuron.new())
	for _i in range(num_hidden):  # 2 neuronas ocultas
		neurons.append(NEATNeuron.new())
	for _i in range(num_outputs):  # 1 neurona de salida
		neurons.append(NEATNeuron.new())
	# Creación de conexiones entre neuronas
	for _i in range(num_inputs * num_hidden + num_hidden * num_outputs):  # Conexiones entre neuronas
		connections.append(NEATConnection.new())
	# Inicialización de pesos aleatorios
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var index := 0
	for _i in range(num_inputs):
		for _j in range(num_hidden):
			connections[index].from_neuron = _i
			connections[index].to_neuron = num_inputs + _j
			connections[index].weight = rng.randf_range(-1.0, 1.0)
			index += 1
	for _i in range(num_outputs):
		for _j in range(num_hidden):
			connections[index].from_neuron = _j
			connections[index].to_neuron = num_inputs + num_hidden + _i
			connections[index].weight = rng.randf_range(-1.0, 1.0)
			index += 1

func _physics_process(delta):
	# Verificar si el pájaro está muerto
	
	if mort == false:
		# Actualizar la fitness        
		fitness = Global.distancia        
		# Aplicar gravedad si no está en el suelo        
		if not is_on_floor():            
			velocity.y += gravity * delta        
		# Saltar si la salida de la red neuronal es mayor que 0.6        
		if Global.population[p].feedforward(inputs())[0] > 0.9:            
			velocity.y = JUMP_VELOCITY        
			print(p)
		# Animación y movimiento si está vivo        
		if life == true:            
			if velocity.y < 0:
				# Animación de subida                
				$AnimatedSprite2D.play()                
				set_rotation(deg_to_rad(velocity.y * 0.05))            
			elif velocity.y > 0: 
				# Animación de bajada               
				set_rotation(deg_to_rad(velocity.y * 0.15))                
				$AnimatedSprite2D.stop()            
			else:
				# Animación de reposo                
				$AnimatedSprite2D.play()                
				set_rotation(0)            
			# Mover y colisionar            
			move_and_collide(velocity * delta)        
		else:
			# Detener animación si no está vivo            
			$AnimatedSprite2D.stop()    
	else:
		# Animación de muerte        
		if not is_on_floor():            
			velocity.y += gravity * delta * 2        
		else:            
			velocity = Vector2(-200, 0)        
		$AnimatedSprite2D.stop()
		if animacio == 0 and velocity.y > 0:
			# Animación de rotación
			$AnimationPlayer.play('rotacio')
			animacio += 1
	
	# Mover y deslizar
	move_and_slide()

func inputs():
	# Entradas para la red neuronal
	var pos_y_bird :float = get_global_position().y #* (24.0/1585.0) + 3.0
	var pos_x_obstacle :float = Global.posicio_obstacle_continua[1] #* (3.0/230.0) - (78.0/23.0)
	var pos_y_obstacle :float = Global.posicio_obstacle_continua[1] #* (3.0/140.0) - (3.0/14.0)
	return [pos_y_bird, pos_x_obstacle, pos_y_obstacle]

func feedforward(inputs):
	# Procesamiento de la red neuronal
	var outputs = []
	for _i in range(num_inputs):
		neurons[_i].output = inputs[_i]
	for _i in range(num_outputs):
		valor(_i + num_inputs + num_hidden)
		outputs.append(sigmoid(neurons[_i + num_inputs + num_hidden].output))
	'''
	for _i in range(num_inputs):
		neurons[_i].output = inputs[_i]
	var value :float = 0.0
	for _j in range(num_hidden):
		value = 0
		for _i in range(num_inputs):
			value += neurons[_i].output * connections[_j + num_hidden * _i].weight
		neurons[num_inputs + _j].output = value
	
	for _j in range(num_outputs):
		value = 0
		for _i in range(num_hidden):
			value += neurons[num_inputs + _i].output * connections[num_inputs * num_hidden + num_outputs * _i + _j].weight
			#print(neurons[num_inputs + _i].output * connections[num_inputs * num_hidden + num_outputs * _i + _j].weight)
		#print(sigmoid(value))
		neurons[num_inputs + num_hidden + _j].output = sigmoid(value)
	for _i in range(num_outputs):
		outputs.append(neurons[num_inputs + num_hidden + _i].output)
	#print(outputs)
	'''
	return outputs

func sigmoid(x):
	# Función sigmoide
	return 1 / (1 + exp(-x))

func valor(n):
	# Valor de una neurona
	var output :float = 0.0
	for conection in connections:
		if conection.to_neuron == n and neurons[conection.from_neuron].output != 0:
			output += neurons[conection.from_neuron].output * conection.weight
		elif conection.to_neuron == n and neurons[conection.from_neuron].output == 0:
			output += valor(conection.from_neuron)
	neurons[n].output = output

func mutar():
	# Mutación de la red neuronal
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randf() < 0.1:
		var n :int = rng.randi_range(0, 4)
		if n == 0:
			# Cambio de peso
			connections[rng.randi_range(0, len(connections))].weight = rng.randf_range(-1, 1)
		elif n == 1:
			for connection in connections:
				if connection.to_neuron == len(neurons) - 1:
					connection.to_neuron += 1
			# Agregar conexión
			connections.insert(len(connections) - 1, NEATConnection.new())
			connections[len(connections) - 2].from_neuron = rng.randi_range(0, len(neurons) - 2)
			connections[len(connections) - 2].to_neuron = rng.randi_range(num_inputs, len(neurons) - 1)
			connections[len(connections) - 2].weight = rng.randf_range(-1.0, 1.0)
		elif n == 2:
			# Agregar neurona y conexión
			neurons.insert(len(neurons) - 1, NEATNeuron.new())
			connections.insert(len(connections) - 1, NEATConnection.new())
			while connections[len(connections) - 2].from_neuron == connections[len(connections) - 2].to_neuron:
				connections[len(connections) - 2].from_neuron = len(neurons) - 2
				connections[len(connections) - 2].to_neuron = rng.randi_range(num_inputs, len(neurons) - 1)
			connections[len(connections) - 2].weight = rng.randf_range(-1.0, 1.0)
			connections.insert(len(connections) - 1, NEATConnection.new())
			connections[len(connections) - 2].from_neuron = rng.randi_range(0, len(neurons) - 3)
			connections[len(connections) - 2].to_neuron = len(neurons) - 1
			connections[len(connections) - 2].weight = rng.randf_range(-1.0, 1.0)
		elif n == 3:
			# Eliminar conexión
			connections.remove_at(rng.randi_range(0, len(connections) - 1))
		elif n == 4:
			# Eliminar neurona
			var m := rng.randi_range(num_inputs, len(neurons) - 2)
			neurons.remove_at(m)
			for connection in connections:
				if connection.to_neuron == m or connection.from_neuron == m:
					connections.erase(connection)
				if connection.to_neuron > m:
					connection.to_neuron -= 1
				if connection.from_neuron > m:
					connection.from_neuron -= 1

func _on_area_2d_body_entered(body):
	# Muerte del pájaro
	mort = true



func mateixa_especie(xarxaNeuronal):
	if len(connections) != len(xarxaNeuronal.connections):
		return false
	for _i in len(connections):
		if not connections[_i].to_neuron == xarxaNeuronal.connections[_i].to_neuron and connections[_i].from_neuron == xarxaNeuronal.connections[_i].from_neuron:
			return false
	return true
