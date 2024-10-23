extends CharacterBody2D

var tilemap
var current_pos = Vector2i(1, 1)

func _ready():
	pass

const SPEED = 1.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if tilemap != null:
		#	motion is using a vector to represent which direction the next tile will be
		var motion = Vector2i(0, 0)
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
			
	#	make sure there is room to move item before updating current_pos
		if is_space_available(motion):
			current_pos = motion + current_pos
			position = tilemap.map_to_local(current_pos)
		

# receives tilemap to calculate whether an item is staying within confines of bag
func set_world_coords(coords: TileMap):
	tilemap = coords
	
# returns true only if tile exists in pocket layer in specified direction
func is_space_available(motion: Vector2i):
	if (tilemap.get_cell_tile_data(0, motion + current_pos)):
		return true
	else:
		return false
