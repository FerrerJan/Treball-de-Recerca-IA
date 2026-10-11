import random

class NEATIndividual:

    def __init__(self):
        self.neurons = []
        self.connections = []
        self.fitness = 0.0
        # Inicialización de la red neuronal
        for _i in range(3):  # 3 neuronas de entrada
            self.neurons.append(NEATNeuron())
        for _i in range(2):  # 2 neuronas ocultas
            self.neurons.append(NEATNeuron())
        for _i in range(1):  # 1 neurona de salida
            self.neurons.append(NEATNeuron())
        for _i in range(3 * 2 + 2 * 1):  # Conexiones entre neuronas
            self.connections.append(NEATConnection())

        # Establecer las conexiones entre las neuronas
        for _i in range(3 * 2 + 2 * 1):
            self.connections[_i].desde = random.random() * 3
            self.connections[_i].to = random.random() * (3 + 2 + 1)
            self.connections[_i].weight = random.random()

        # Establecer los inputs
        for _i in range(3):
            self.neurons[_i].output = 1.0  # Entradas fijas

        # Establecer los outputs
        for _i in range(1):
            self.neurons[_i + 3].output = 0.0  # Salida inicial
    
    def __repr__(self) -> str:
        n = ''
        for neuron in self.neurons:
            n += str(neuron.output) + ' - '
        return n

class NEATNeuron:

    def __init__(self):
        self.output = 0.0

class NEATConnection:

    def __init__(self):
        self.desde = 0
        self.to = 0
        self.weight = 0.0
    

n = NEATIndividual()
print(n)
