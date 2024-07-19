extends Node2D

class ia:
	var neurons = []
	var connections = []
	var fitness :float = 0.0
	var num_inputs :int = Global.inputs.size()
	var num_hidden :int = 0
	var num_outputs :int = 1
	
	func _init():
		xarxa_aleatoria()
		

	class NEATNeuron:
		var output = 0.0

	class NEATConnection:
		var from_neuron = 0
		var to_neuron = 0
		var weight = 0.0

	func xarxa_aleatoria():
		# Inicialización de la escena
		# Creación de neuronas de entrada, ocultas y salida
		for _i in range(num_inputs):  # 3 neuronas de entrada
			neurons.append(NEATNeuron.new())
		for _i in range(num_hidden):  # 2 neuronas ocultas
			neurons.append(NEATNeuron.new())
		for _i in range(num_outputs):  # 1 neurona de salida
			neurons.append(NEATNeuron.new())
		# Inicialización de pesos aleatorios
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var index := 0
		if num_hidden > 0:
			for _i in range(num_inputs * num_hidden + num_hidden * num_outputs):  # Conexiones entre neuronas
				connections.append(NEATConnection.new())
			for _i in range(num_inputs):
				for _j in range(num_hidden):
					connections[index].from_neuron = _i
					connections[index].to_neuron = num_inputs + _j
					connections[index].weight = rng.randf_range(-1.0, 1.0)
					index += 1
					
			for _i in range(num_outputs):
				for _j in range(num_hidden):
					connections[index].from_neuron = _j + num_inputs
					connections[index].to_neuron = num_inputs + num_hidden + _i
					connections[index].weight = rng.randf_range(-1.0, 1.0)
					index += 1
		
		else:
			for _i in range(num_inputs * num_outputs):  # Conexiones entre neuronas
				connections.append(NEATConnection.new())
			for _i in range(num_inputs):
				for _j in range(num_outputs):
					connections[index].from_neuron = _i
					connections[index].to_neuron = num_inputs + _j
					connections[index].weight = rng.randf_range(-1.0, 1.0)
					index += 1


	func feedforward(inputs):
		# Procesamiento de la red neuronal
		var outputs = []
		for _i in range(num_inputs):
			neurons[_i].output = inputs[_i]
		for _i in range(num_outputs):
			valor(_i + num_inputs + num_hidden, 1)
			outputs.append(sigmoid(neurons[_i + num_inputs + num_hidden].output))
		return outputs


	func sigmoid(x):
		# Función sigmoide
		return 1 / (1 + exp(-x))

	func valor(n, m):
		# Valor de una neurona
		var output :float = 0.0
		if m > 1000:
			neurons[n].output = 0
			return 0
		for conection in connections:
			if conection.to_neuron == n and neurons[conection.from_neuron].output != 0:
				output += neurons[conection.from_neuron].output * conection.weight
			elif conection.to_neuron == n and neurons[conection.from_neuron].output == 0:
				output += valor(conection.from_neuron, m + 1)
		neurons[n].output = output
		return output

	func mutar(xarxaNeuronalOriginal):
		# Mutación de la red neuronal
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var num_neurons := neurons.size()
		var num_connections := connections.size()
		for _j in range(1000):
			var n :int = rng.randi_range(0, 4)
			if n == 0 and num_connections > 0 and Global.mutacions.find(0) != -1:
				# Cambio de peso
				connections[rng.randi_range(0, num_connections - 1)].weight = rng.randf_range(-1.0, 1.0)
			elif n == 1 and Global.mutacions.find(1) != -1:
				# Agregar conexión
				if maxconnections() > num_connections:
					connections.append(NEATConnection.new())
					var enable := false
					for _i in range(1000):
						if connections[num_connections].from_neuron == connections[num_connections].to_neuron or !enable:
							connections[num_connections].from_neuron = rng.randi_range(0, num_neurons - 2)
							connections[num_connections].to_neuron = rng.randi_range(num_inputs, num_neurons - 1)
							for connection in connections:
								if connections[num_connections].from_neuron == connection.to_neuron and connections[num_connections].to_neuron == connection.from_neuron:
									enable = false
									break
								enable = true
						else:
							break
					connections[num_connections].weight = rng.randf_range(-1.0, 1.0)
				else:
					n += 1
			elif n == 2 and Global.mutacions.find(1) != -1:
				# Eliminar conexión
				connections.remove_at(rng.randi_range(0, num_connections - 1))
			elif n == 3 and Global.mutacions.find(1) != -1:
				# Agregar neurona y conexiónes a esta
				for connection in connections:
					if connection.to_neuron == num_neurons - 1:
						connection.to_neuron = num_neurons
				neurons.insert(num_neurons - 1, NEATNeuron.new())
				connections.append(NEATConnection.new())
				connections.append(NEATConnection.new())
				for i in range(1000):
					connections[num_connections].to_neuron = rng.randi_range(num_inputs, num_neurons)
					connections[num_connections + 1].from_neuron = rng.randi_range(0, num_neurons - 2)
					if connections[num_connections].to_neuron != num_neurons - 1 and connections[num_connections].to_neuron != connections[num_connections + 1].from_neuron:
						break
					else:
						connections[num_connections].to_neuron = num_neurons
				connections[num_connections].from_neuron = num_neurons - 1
				connections[num_connections].weight = rng.randf_range(-1.0, 1.0)
				connections[num_connections + 1].to_neuron = num_neurons - 1
				connections[num_connections + 1].weight = rng.randf_range(-1.0, 1.0)
				num_hidden += 1
			elif n == 4 and num_neurons > num_inputs + num_outputs and Global.mutacions.find(1) != -1:
				# Eliminar neurona
				var m := rng.randi_range(num_inputs, num_neurons - 2)
				neurons.remove_at(m)
				for i in range(num_connections - 1, -1, -1):
					if connections[i].to_neuron == m or connections[i].from_neuron == m:
						connections.remove_at(i)
					else:
						if connections[i].to_neuron > m:
							connections[i].to_neuron -= 1
						if connections[i].from_neuron > m:
							connections[i].from_neuron -= 1
				num_hidden -= 1
			if !iguals(xarxaNeuronalOriginal):
				break
			
	func mateixa_especie(xarxaNeuronal):
		if connections.size() != len(xarxaNeuronal.connections):
			return false
		for _i in connections.size():
			if not connections[_i].to_neuron == xarxaNeuronal.connections[_i].to_neuron and connections[_i].from_neuron == xarxaNeuronal.connections[_i].from_neuron:
				return false
		return true
		
	func copia(xarxaNeuronal):
		neurons = []
		for _j in range(xarxaNeuronal.neurons.size()):
			neurons.append(NEATNeuron.new())
		connections = []
		for _j in range(xarxaNeuronal.connections.size()):
			connections.append(NEATConnection.new())
			connections[connections.size() - 1].to_neuron = xarxaNeuronal.connections[_j].to_neuron
			connections[connections.size() - 1].from_neuron = xarxaNeuronal.connections[_j].from_neuron
			connections[connections.size() - 1].weight = xarxaNeuronal.connections[_j].weight
		num_inputs = xarxaNeuronal.num_inputs
		num_hidden = xarxaNeuronal.num_hidden
		num_outputs = xarxaNeuronal.num_outputs
		fitness = 0

	func maxconnections():
		var maxconnections :int = 0
		maxconnections += num_inputs * num_hidden + num_inputs * num_outputs + num_hidden * num_outputs
		maxconnections += maxconnectionsinlayer(num_inputs)
		maxconnections += maxconnectionsinlayer(num_hidden)
		maxconnections += maxconnectionsinlayer(num_outputs)
		return maxconnections

	func maxconnectionsinlayer(numneurons):
		var numconnections :int = 0
		for n in range(numneurons):
			numconnections += n
		return numconnections
	
	func crossover(x1, x2):
		if x1.mateixa_especie(x2):
			copia(x1)
			for i in range(len(connections)):
				connections[i].weight = (x1.connections[i].weight + x2.connections[i].weight) / 2

	func iguals(xarxaNeuronal):
		if !mateixa_especie(xarxaNeuronal):
			return false
		for i in connections.size():
			if connections[i].weight != xarxaNeuronal.connections[i].weight:
				return false
		return true
		
	func mostra():
		var visualitzacio := ''
		visualitzacio += 'Neurones input: ' + str(num_inputs)
		visualitzacio += '\nNeurones amagades: ' + str(num_hidden)
		visualitzacio += '\nNeuornes output: ' + str(num_outputs)
		visualitzacio += '\nConexions:'
		for connection in connections: 
			visualitzacio += '\nDesde: ' + str(connection.from_neuron) + ' - Fins: ' + str(connection.to_neuron) + ' - Importancia: ' + str(connection.weight)
		return visualitzacio
		
	func asignar_val_global(num):
		var f = 0
		var conexions_millor : = ''
		if num == 0: 
			return str(num_inputs)
		elif num == 1:
			return str(num_hidden)
		elif num == 2:
			return str(num_outputs)
		elif num == 3:
			for i in connections:
				if f == 0:
					conexions_millor += '{\n"desde" :' + str(i.from_neuron) + ',\n"fins" :' + str(i.to_neuron) + ',\n"importancia" :' + str(i.weight) + '}'
				else:
					conexions_millor += ',\n{\n"desde" :' + str(i.from_neuron) + ',\n"fins" :' + str(i.to_neuron) + ',\n"importancia" :' + str(i.weight) + '}'
				f += 1
			return conexions_millor 
					
					
		
		
		
		
