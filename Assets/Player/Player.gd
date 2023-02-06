extends KinematicBody2D

# var to store velocity
var velocity = Vector2.ZERO

const ACCELARATION = 1800  
const MAX_SPEED = 2500
const FRICTION = 1500

func _physics_process(delta):
	
	# this var willl contain the key input
	var input_vector = Vector2.ZERO
	
	# here we will check key-input and if the key is pressed the value will be 1 otherwise 0
	input_vector.x = Input.get_action_strength("Move_right") - Input.get_action_strength("Move_left")
	input_vector.y = Input.get_action_strength("Move_down") - Input.get_action_strength("Move_up")
	
	#normalizing the digonal speed to match the speed in the h and v direction
	input_vector = input_vector.normalized()
	
	# checking if the key is pressed or not and setting the velocity
	if input_vector != Vector2.ZERO :
		velocity += input_vector * ACCELARATION * delta
		velocity = velocity.clamped(MAX_SPEED)
	else:
		# move the velocity toward zero with fixed rate
		velocity = velocity.move_toward(Vector2.ZERO , FRICTION * delta)
	
	#inbuild godot function to move the kinematic body along the provided vector
	move_and_slide(velocity * delta)
