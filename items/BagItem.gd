extends CharacterBody2D

var tilemap
var current_pos = Vector2i(1, 1)

func _ready():
	pass

const SPEED = 1.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var motion = Vector2i(0, 0)
	
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
		
	if is_space_available(motion):
		current_pos = motion + current_pos
		position = tilemap.map_to_local(current_pos)
		

func set_world_coords(coords: TileMap):
	tilemap = coords
	
func is_space_available(motion: Vector2i):
	print(motion + current_pos)
	print(tilemap.get_cell_tile_data(0, motion + current_pos))
	if (tilemap.get_cell_tile_data(0, motion + current_pos)):
		return true
	else:
		return false
