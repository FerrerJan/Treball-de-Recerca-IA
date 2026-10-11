extends CharacterBody2D


# Constantes
const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var animacio = 0

# Constantes de gravedad y velocidad
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/1.4
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var label = $Label

var mort := false
var life := true
var p := 0
var moneda_aconseguida := true

func inici():
	Global.population[p].fitness = 0
	label.text = str(p)

func _physics_process(delta):
	delta *= Global.velocitat_joc
	var pos_y_bird :float = get_global_position().y
	var pos_y_obstacle :float = Global.posicio_obstacle_continua[1]
	# Verificar si el pájaro está muerto
	if mort == false and Global.mort == false:
		# Actualizar la fitness 
		actualizar_fitness(delta)
		#resaltar pajaro con mayor popolación
		if p == Global.max_fitness_index:
			animated_sprite_2d.set_self_modulate(Color8(255, 255, 255, 255))
		else:
			animated_sprite_2d.set_self_modulate(Color8(255, 255, 255, 100)) 
		# Aplicar gravedad si no está en el suelo        
		if not is_on_floor():            
			velocity.y += gravity * delta        
		# Saltar si la salida de la red neuronal es mayor que 0.6  
		var feedforward :Array = Global.population[p].feedforward(inputs())
		if feedforward[0] > 0.7 :    
			velocity.y = JUMP_VELOCITY
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
			Global.population[p].fitness -= 100    
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
	var pos_y_bird_entre_pos_y_obstacle :float = get_global_position().y / Global.posicio_obstacle_continua[1]
	var pos_y_bird :float = get_global_position().y
	var pos_y_obstacle :float = Global.posicio_obstacle_continua[1]
	var pos_x_obstacle :float = Global.posicio_obstacle_continua[0]
	var pos_y_bird_entre_pos_y_moneda :float = get_global_position().y / Global.posicio_moneda_continua[1]
	var velocitat :float = velocity.y
	var moneda_aconseguida_i : int = 1
	if moneda_aconseguida:
		moneda_aconseguida_i = 1
	else:
		moneda_aconseguida_i = 0
		
	
	var all_inputs := [pos_y_bird_entre_pos_y_obstacle, pos_y_bird_entre_pos_y_moneda, pos_y_bird, pos_y_obstacle, pos_x_obstacle, velocitat, moneda_aconseguida_i]
	var inputs := []
	
	for i in Global.inputs:
		inputs.append(all_inputs[i])
	return inputs
	
		


func _on_area_2d_body_entered(body):
	# Muerte del pájaro
	mort = true

func actualizar_fitness(delta):
	Global.population[p].fitness += 1.0 * delta
	if moneda_aconseguida:
		if abs(global_position.y - Global.posicio_obstacle_continua[1]) < 10:
			Global.population[p].fitness += 100.0 * delta
		elif abs(global_position.y - Global.posicio_obstacle_continua[1]) < 50:
			Global.population[p].fitness += 50.0 * delta
		elif abs(global_position.y - Global.posicio_obstacle_continua[1]) < 100:
			Global.population[p].fitness += 10.0 * delta
		elif abs(global_position.y - Global.posicio_obstacle_continua[1]) < 200:
			Global.population[p].fitness += 5.0 * delta
	else:
		if abs(global_position.y - Global.posicio_moneda_continua[1]) < 10:
			Global.population[p].fitness += 100.0 * delta
		elif abs(global_position.y - Global.posicio_moneda_continua[1]) < 50:
			Global.population[p].fitness += 50.0 * delta
		elif abs(global_position.y - Global.posicio_moneda_continua[1]) < 100:
			Global.population[p].fitness += 10.0 * delta
		elif abs(global_position.y - Global.posicio_moneda_continua[1]) < 200:
			Global.population[p].fitness += 5.0 * delta

func moneda():
	moneda_aconseguida = true
	Global.population[p].fitness += 1000
	print(moneda_aconseguida)
