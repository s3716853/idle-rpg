extends CharacterBody2D

var tilemap

func _ready():
	pass

const SPEED = 32.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var motion = Vector2(0, 0)
	
# snap item to grid using hardcoded values, not connected to TileMap with logic yet
	
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_down"):
		motion.x = 0
		motion.y = SPEED
	if Input.is_action_just_pressed("ui_up"):
		motion.x = 0
		motion.y = -SPEED
	if Input.is_action_just_pressed("ui_left"):
		motion.x = -SPEED
		motion.y = 0
	if Input.is_action_just_pressed("ui_right"):
		motion.x = SPEED
		motion.y = 0
		
	move_and_collide(motion)
		

func set_world_coords(coords: TileMap):
	tilemap = coords
	print(tilemap.get_cell_tile_data(0, Vector2i(1, 1)))
	
func test():
	print(tilemap)
