extends CharacterBody2D


const SPEED = 300.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var motion = Vector2(0, 0)
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_down"):
		motion = Vector2(0, 32)
	if Input.is_action_just_pressed("ui_up"):
		motion = Vector2(0, -32)
	if Input.is_action_just_pressed("ui_left"):
		motion = Vector2(-32, 0)
	if Input.is_action_just_pressed("ui_right"):
		motion = Vector2(32, 0)
		
	move_and_collide(motion)
		
