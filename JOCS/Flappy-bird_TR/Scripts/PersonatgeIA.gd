extends CharacterBody2D

# Constantes
const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var animacio = 0

# Constantes de gravedad y velocidad
var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/1.4


var mort := false
var life := true
var p := 0

func _ready():
	Global.population[p].fitness = 0

func _physics_process(delta):
	# Verificar si el pájaro está muerto
	if global_position.y < 0:
		Global.population[p].fitness -= 1
	if mort == false and Global.mort == false:
		# Actualizar la fitness 
		Global.population[p].fitness = Global.distancia  
		# Aplicar gravedad si no está en el suelo        
		if not is_on_floor():            
			velocity.y += gravity * delta        
		# Saltar si la salida de la red neuronal es mayor que 0.6        
		if Global.population[p].feedforward(inputs())[0] > 0.9:    
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
	var pos_y_bird :float = get_global_position().y
	var pos_x_obstacle :float = Global.posicio_obstacle_continua[1]
	var pos_y_obstacle :float = Global.posicio_obstacle_continua[1]
	var velocitat :float = velocity.y
	var top :float = 0.0
	var bot :float = 395.0
	return [pos_y_bird, pos_y_obstacle]


func _on_area_2d_body_entered(body):
	# Muerte del pájaro
	mort = true

