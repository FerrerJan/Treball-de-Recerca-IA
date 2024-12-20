extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -200.0
var animacio = 0

var gravity = (ProjectSettings.get_setting("physics/2d/default_gravity"))/1.4


func _physics_process(delta):
	delta *= Global.velocitat_joc
	if Global.mort == false:
		if not is_on_floor():
			velocity.y += gravity * delta
		if Input.is_action_just_pressed("espai"):
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

