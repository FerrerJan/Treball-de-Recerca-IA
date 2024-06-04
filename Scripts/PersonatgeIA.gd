extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var animacio = 0

var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/1.4


func _physics_process(delta):
    var inputs := [get_global_position().y, # Posició y de l'ocell
    Global.posicio_obstacle_continua[0],    # Posició x de l'obstacle
    Global.posicio_obstacle_continua[1]]    # Posició y de l'obstacle
	if Global.mort == false:
		if not is_on_floor():
			velocity.y += gravity * delta
		if feedforward(inputs) => 0.6:
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



#Classe xarxa neuronal
class NEATIndividual:
    var neurons = []
    var connections = []
    var fitness = 0.0
    var num_inputs = 3
    var num_hidden = 2
    var num_outputs = 1

    func __init__():
        # Inicialización de la red neuronal
        for _i in range(3):  # 3 neuronas de entrada
            neurons.append(NEATNeuron.new())
        for _i in range(2):  # 2 neuronas ocultas
            neurons.append(NEATNeuron.new())
        for _i in range(1):  # 1 neurona de salida
            neurons.append(NEATNeuron.new())
        for _i in range(3 * 2 + 2 * 1):  # Conexiones entre neuronas
            connections.append(NEATConnection.new())

        # Establecer las conexiones entre las neuronas
        var rng = RandomNumberGenerator.new()
        rng.randomize()
        for _i in range(3 * 2 + 2 * 1):
            connections[_i].from_neuron = rng.randi() % 3
            connections[_i].to_neuron = rng.randi() % (3 + 2 + 1)
            connections[_i].weight = rng.randf() * 2 - 1

        # Establecer los inputs
        for _i in range(3):
            neurons[_i].output = 1.0  # Entradas fijas

        # Establecer los outputs
        for _i in range(1):
            neurons[_i + 3].output = 0.0  # Salida inicial

        func evaluate_fitness():
            # Evaluación del desempeño del individuo
            pass


    def __repr__(self) -> str:
        n = ''
        for neuron in self.neurons:
            n += str(neuron.output) + ' - '
        return n


    func mutate():
        # Mutación de la red neuronal
        if randf() < NEAT_MUTATION_RATE:
            # Agregar una nueva conexión
            var new_connection = NEATConnection.new()
            new_connection.from = randi() % neurons.size()
            new_connection.to = randi() % neurons.size()
            connections.append(new_connection)
        if randf() < NEAT_MUTATION_RATE:
            # Eliminar una conexión
            var index = randi() % connections.size()
            connections.remove(index)
        if randf() < NEAT_MUTATION_RATE:
            # Cambiar el peso de una conexión
            var index = randi() % connections.size()
            connections[index].weight = randf() * 2 - 1


    func crossover(parent1, parent2):
        # Crossover entre dos individuos
        var child = NEATIndividual.new()
        for _i in range(10):
            if randf() < NEAT_CROSSOVER_RATE:
                child.neurons.append(parent1.neurons[randi() % parent1.neurons.size()])
            else:
                child.neurons.append(parent2.neurons[randi() % parent2.neurons.size()])
        for _i in range(10):
            if randf() < NEAT_CROSSOVER_RATE:
                child.connections.append(parent1.connections[randi() % parent1.connections.size()])
            else:
                child.connections.append(parent2.connections[randi() % parent2.connections.size()])
        return child


    func evaluate_fitness():
        # Evaluación del desempeño del individuo
        var total = 0.0
        for connection in connections:
            total += connection.weight * neurons[connection.from].output * neurons[connection.to].output
        fitness = total


    func feedforward(inputs):
        for i in range(num_inputs):
            neurons[i].output = inputs[i]
        for i in range(num_hidden):
            neurons[num_inputs + i].output = sigmoid(sum([neurons[num_inputs + i].output * neurons[num_inputs + i].weight for j in range(num_inputs)]))
        for i in range(num_outputs):
            neurons[num_inputs + num_hidden + i].output = sigmoid(sum([neurons[num_inputs + num_hidden + i].output * neurons[num_inputs + num_hidden + i].weight for j in range(num_hidden)]))
        return [neurons[num_inputs + num_hidden + i].output for i in range(num_outputs)]



#Classe neurona
class NEATNeuron:
    var output = 0.0

    func __init__():
        pass



#Classe conexió neuronal
class NEATConnection:
    var from_neuron = 0
    var to_neuron = 0
    var weight = 0.0

    func __init__():
        pass
