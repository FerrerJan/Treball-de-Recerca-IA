extends Node

const NEAT_POPULATION_SIZE = 100
const NEAT_GENERATIONS = 1000
const NEAT_MUTATION_RATE = 0.1
const NEAT_CROSSOVER_RATE = 0.5

var population = []
var best_individual = null

func _ready():
	for _i in range(NEAT_POPULATION_SIZE):
		population.append(NEATIndividual.new())


func _process(delta):
	# Evaluación de la fitness
	for individual in population:
		individual.evaluate_fitness()

	# Selección
	population.sort(func(a, b): return a.fitness > b.fitness)
	population = population[:NEAT_POPULATION_SIZE]

	# Mutación
	for individual in population:
		if randf() < NEAT_MUTATION_RATE:
			individual.mutate()

	# Crossover
	for _i in range(int(NEAT_POPULATION_SIZE * NEAT_CROSSOVER_RATE)):
		parent1 = population[randi() % NEAT_POPULATION_SIZE]
		parent2 = population[randi() % NEAT_POPULATION_SIZE]
		child = NEATIndividual.new()
		child.crossover(parent1, parent2)
		population.append(child)

	# Actualización del mejor individuo
	best_individual = population[0]
	for individual in population:
		if individual.fitness > best_individual.fitness:
			best_individual = individual

class NEATIndividual:
	var neurons = []
	var connections = []
	var fitness = 0.0

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
