extends Node2D

@export var escena_obstacle: PackedScene
@export var min : float = -145
@export var max : float = 126
@onready var timer = $Obstacles/Timer

var num_generacions : int = 0
var max_puntuacio : int = 0
var num_ia : int = 0
var num_joc : int = 0 

var random_number: float
var posicio: float
var posicio_obstacles = Vector2(0,0)
var Vpos_personatge : Vector2
@onready var collision = $CollisionShape2D
var activat := false


	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.mort = false
	Global.iniciat = false
	Global.Z = 1
	Global.punts = 0
	Global.distancia = 0
	Global.posicio_obstacle = 0
	$resultat.visible = false
	$Contador2.visible = false
	$maxim.visible = false
	Global.I = 0
	posicio = 0
	Global.morts_ia = 0
	Global.posicio_obstacle_continua = Vector2(490, 207)
	timer.wait_time /= Global.velocitat_joc
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta *= Global.velocitat_joc
	#print(Global.gen)
	if !Global.mort:
		var fitness := []
		for i in Global.population:
				fitness.append(i.fitness)
		Global.max_fitness_gen = fitness.max()
		if Global.max_fitness_partida < fitness.max():
			Global.max_fitness_partida = fitness.max()
			Global.millor_ocell_partida.copia(Global.population[fitness.find(fitness.max())])
		Global.max_fitness_index = fitness.find(fitness.max())
		#print(fitness)
	if Global.repetir == true and Global.iniciat == false:
		Global.iniciat = true
		$Obstacles/Timer.start()
		$volar_principi/CollisionShape2D.disabled = true
		$clicar.visible = false
		$clicar2.visible = false
		
		if Global.IA == true:
			$CharacterBody2D.queue_free()
			Global.Z = 0
		
	if Input.is_action_just_pressed("espai") and Global.iniciat == false:
		Global.iniciat = true
		$Obstacles/Timer.start()
		$volar_principi/CollisionShape2D.disabled = true
		$clicar.visible = false
		$clicar2.visible = false
		
		if Global.IA == true:
			$CharacterBody2D.queue_free()
			Global.Z = 0
			
	if Global.morts_ia >= Global.num_IA and Global.IA == true:
		Global.gen_seguides_amb_puntuació_maxima = 0
		Global.mort = true
		
	#print(str(Global.morts_ia)+' / '+str(Global.num_IA) )
	
	$Contador.text = str(Global.punts)
	$Contador2.text = str(Global.punts)
	$maxim.text = str(Global.maxim)
	
	if Global.punts > Global.maxim:
		Global.maxim = Global.punts 
	
	if Global.punts >= Global.puntuacio_max:
		Global.gen_seguides_amb_puntuació_maxima += 1
		Global.mort = true
			
	if Input.is_action_just_pressed("enter") and Global.mort == true:
		get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
	
	if Global.mort == true and Global.I == 0 and Global.IA == false:
		posicio = $CharacterBody2D.get_global_position().y
		Global.I += 1
		print('')
		print('-------------------------------------------------')
		print('Distancia recorreguda: ' + str(Global.distancia))
		print('Punts: ' + str(Global.punts))
		print('Altura personatge: ' + str(posicio))
		print('Altura del forat: '+ str(Global.posicio_obstacle))
		print('-------------------------------------------------')
		print('')
	
	
	if Input.is_action_just_pressed("I"):
		Global.IA = !Global.IA
		Global.noIA = !Global.noIA
		get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
	
	if Input.is_action_just_pressed("R"):
		Global.mort = true
		
	if Input.is_action_just_pressed("Xarxa_aleatoria"): #Tecla 'A'
		for ia in Global.population:
			ia.xarxa_aleatoria()
			
	if Input.is_action_just_pressed("K"):
		Global.repetir = !Global.repetir
		#get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
	
	if Global.mort:
		guardar_dades_gen()
		
		if Global.gen >= Global.num_gen_max or Global.gen_seguides_amb_puntuació_maxima >= 3:
			print(Global.partidas)
			guardar_dades_partida()
			Global.gen = 0
			Global.partidas += 1
			Global.gen_seguides_amb_puntuació_maxima = 0
			
		if Global.partidas >= Global.num_partidas:
			get_tree().change_scene_to_file("res://Escenes/inteficie.tscn")
			guardar_dades_arxiu()
			desa_arxiu()
			desa_dades()
			desa_json()
			#dades json
			Global.dades = ''
			Global.dades_json = ''
			
		elif Global.repetir == false:
			$Obstacles/Timer.stop()
			$resultat.visible = true
			$Contador.visible = false
			$Contador2.visible = true
			$maxim.visible = true
		else:
			get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")
		
func _on_timer_timeout():
	if Global.iniciat == true:
		$Obstacles/Timer.start()
		random_number = randi_range(min, max)
		crea_obstacle(posicio_obstacles)
	else:
		$Obstacles/Timer.stop()
	
func crea_obstacle(posicio: Vector2):
	var nou_obstacle = escena_obstacle.instantiate()
	nou_obstacle.global_position = posicio + Vector2(0, random_number)
	$Obstacles.add_child(nou_obstacle)

'''
func _on_puntuacio_area_entered(area):
	Global.population[area.p].fitness += 200.0
'''

func _on_obsacles_eliminar_area_entered(area):
	area.queue_free()
	#print('eliminat')


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Escenes/escena_ia.tscn")


func _on_puntuacio_area_exited(area):
	Global.punts += 1
	for i in range($Creador_de_IAs.get_child_count()):
		Global.population[$Creador_de_IAs.get_child(i).p].fitness += 1000.0
	#Global.population[get_parent().area.p].fitness += 1000.0
	Global.posicio_obstacle_continua[0] = 490
	#print(Global.punts)
	
func guardar_dades_gen():
	'''
	Global.max_fitness_gen
	Global.gen
	'''
	
	Global.dades += 'Generació: ' + str(Global.gen) + ' - Fitness: ' + str(Global.max_fitness_gen) + '\n'
	Global.dades_PY += str(Global.max_fitness_gen) + ", "
	
	#-------------------------------------------------
	if Global.gen != 1:
		Global.dades_gen_json += ',\n{\n' + '"num_generacio" : ' + str(Global.gen) + ',\n' + '"fitness" : ' + str(Global.max_fitness_gen) + '\n}'
	else:
		Global.dades_gen_json += '{\n' + '"num_generacio" : ' + str(Global.gen) + ',\n' + '"fitness" : ' + str(Global.max_fitness_gen) + '\n}'
	
	print("PARTIDA: " + str(Global.partidas) + " _________ GEN: " + str(Global.gen))
func guardar_dades_partida():
	'''
	Global.partidas
	Global.max_fitness_partida
	Global.millor_ocell_partida
	'''
	
	Global.dades += 'Partida: ' + str(Global.partidas) + '\nMàxim fitness de la partida: ' + str(Global.max_fitness_partida) + '\nMillor ocell de la partida:\n' + Global.millor_ocell_partida.mostra() + '\n------------------------------------------------------------------------\n'
	Global.dades_PY += "\n"
	
	#------------------------------------------------------------
	if Global.partidas != 0:
		Global.dades_json += ',\n{\n' + '"num_partida" :' + str(Global.partidas) + ',\n"generacions" :' + '\n[\n' + str(Global.dades_gen_json) + '\n],\n' + '"màxim_fitness" :' + str(Global.max_fitness_partida) + ',\n"millor_ocell" :' +  '\n{\n' + '"neurones_input" : ' + str(Global.millor_ocell_partida.asignar_val_global(0)) + ',\n"neurones_amagades" :' + str(Global.millor_ocell_partida.asignar_val_global(1)) + ',\n"neuornes_output" :' + str(Global.millor_ocell_partida.asignar_val_global(2)) + ',\n"conexions" : [\n' + str(Global.millor_ocell_partida.asignar_val_global(3)) + '\n]' +'\n}\n' + '}'                                                   
	else:
		Global.dades_json += '{\n' + '"num_partida" :' + str(Global.partidas) + ',\n"generacions" :' + '\n[\n' + str(Global.dades_gen_json) + '\n],\n' + '"màxim_fitness" :' + str(Global.max_fitness_partida) + ',\n"millor_ocell" :' +  '\n{\n' + '"neurones_input" : ' + str(Global.millor_ocell_partida.asignar_val_global(0)) + ',\n"neurones_amagades" :' + str(Global.millor_ocell_partida.asignar_val_global(1)) + ',\n"neuornes_output" :' + str(Global.millor_ocell_partida.asignar_val_global(2)) + ',\n"conexions" :[\n' + str(Global.millor_ocell_partida.asignar_val_global(3)) + '\n]' +'\n}\n' + '}'
		
	Global.dades_gen_json = ''
func guardar_dades_arxiu():
	'''
	Global.inputs
	Global.num_poblacio
	Global.num_gen_max
	Global.puntuacio_max
	Global.num_partidas
	'''
	Global.dades += 'Configuració:'
	Global.dades += '\nPoblació: ' + str(Global.num_poblacio)
	Global.dades += '\nInputs: ' + str(Global.inputs)
	Global.dades += '\nMutacions: ' + str(Global.mutacions)
	Global.dades += '\nPartides totals: ' + str(Global.num_partidas)
	Global.dades += '\nGeneracions totals: ' + str(Global.num_gen_max)
	Global.dades += '\nPuntuació màxima: ' + str(Global.puntuacio_max)
	 	
'''func desa_arxiu():
	
	
	var file_name = 'res://dades/' + nom + str(num) + '.txt'
	#canviar per cada persona 
	var file = FileAccess.open(file_name, FileAccess.READ)
	
	
	if file == null:
		#file.seek_end()
		file.store_string(dades + "\n")
		print(dades)
		file.close()
	else:
		num += 1
		desa_arxiu()
		file.close()
	'''
	
func desa_arxiu():
	Global.nom = ('Població-' + str(Global.num_poblacio) + '_Inputs-' + str(Global.inputs) + '_Mutacions-' + str(Global.mutacions)).replace(' ', '')
	
	var file_name = "res://Dades/" + Global.nom + '_' + str(Global.num) + '.txt'
	var PY_file_name = "res://DadesExcel/" + "PY_" + Global.nom + '_' + str(Global.num) + '.txt'
	var file = null
	# Intenta obrir el fitxer en mode lectura per comprovar si existeix
	var file_exists = false
	file = FileAccess.open(file_name, FileAccess.READ)
	
	if file != null:
		file_exists = true
	else:
		file_exists = false

	# Si el fitxer no existeix, crea'l i desa les dades
	if not file_exists:
		file = FileAccess.open(file_name, FileAccess.WRITE)
		file.store_string(Global.dades + "\n")
		file.close()
		Global.num = 0
	else:
		Global.num += 1
		desa_arxiu()
		file.close()
		
		
func desa_dades():
	var file_name = "res://Dades/" + Global.nom + '_' + str(Global.num) + '.txt'
	var PY_file_name = "res://DadesExcel/" + "PY_" + Global.nom + '_' + str(Global.num) + '.txt'
	var file = null
	var file_exists = false
	# REPETIR EL PROCES AMB UN FITXER QUE EL CODI DE PYTHON PROCESSI
	file = null
	file_exists = false
	file = FileAccess.open(PY_file_name, FileAccess.READ)
	if file != null:
		file_exists = true
	else:
		file_exists = false

	# Si el fitxer no existeix, crea'l i desa les dades
	if not file_exists:
		file = FileAccess.open(PY_file_name, FileAccess.WRITE)
		file.store_string(Global.dades_PY + "\n")
		file.close()
		Global.num = 0
	else:
		Global.num += 1
		desa_dades()
		file.close()
		
func desa_json():
	
	var current_time = Time.get_datetime_dict_from_system()
	
	var data : String = str(current_time['day']) + '/' + str(current_time['month']) + '/' + str(current_time['year']) + ' ' + str(current_time['hour']) + ':' + str(current_time['minute']) + ':' + str(current_time['second']) 
	
	
	var file_name = "res://Dades Json/" + Global.nom + '_' + str(Global.num) + '.json'
	var file = null
	var file_exists = false
	
	var dades : String = '{\n' + '"nom_fitxer" : "' + str(file_name) + '",\n"data_mostra" : "' + str(data) + '",\n"configuracio" :\n{\n"població" : ' + str(Global.num_poblacio) + ',\n"inputs" : ' + str(Global.inputs) + ',\n"mutacions" : ' + str(Global.mutacions) + ',\n"partides_totals" : ' + str(Global.num_partidas) + ',\n"generacions totals" : ' + str(Global.num_gen_max) + ',\n"Puntuació màxima" : ' + str(Global.puntuacio_max) + '\n},\n"partides" : [\n' + str(Global.dades_json) + '\n]\n}'
	
	file = null
	file_exists = false
	file = FileAccess.open(file_name, FileAccess.READ)
	if file != null:
		file_exists = true
	else:
		file_exists = false

	
	if not file_exists:
		file = FileAccess.open(file_name, FileAccess.WRITE)
		file.store_string(dades + "\n")
		file.close()
		Global.num = 0
	else:
		Global.num += 1
		desa_json()
		file.close()


	
	
	


		
