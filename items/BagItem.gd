extends CharacterBody2D

var tilemap

# used to differentiate between items of the same type e.g. health potion 1, health potion 2
# (for affinity further down the line)
var id

# array of vectors that make up the physical space of the item
# basically represents the cursor on screen - bigger items have a larger cursor
# currently filled with hardcoded vector, will be calculated in future
var current_pos = [Vector2i(1, 1)]

# array of vectors that make up the space required to calculate rotating an item in an n * n matrix,
# where n is the longest dimension of the item
# e.g. an item that is 3x1 in physical size has a rotation matrix of size 3x3
# currently filled with hardcoded vector, will be calculated in future
var rotation_matrix = [Vector2i(1, 1)]

# the vector used as the centre point of the item - mostly used to calculate what the item's
# position is in local coordinate space outside of the tilemap system
# currently filled with hardcoded vector, will be calculated in future
var centre_vector = Vector2i(2,2)

# bool to make sure item is selected, keeps unselected items from moving around in the bag
var is_item_selected = false

# the scene passed through to the BagItem script that represents the item
var scene:Node

func _ready():
	pass
	
func set_id(item_id: int):
	id = item_id

const SPEED = 1.0

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if is_item_selected:
		#	motion is using a vector to represent which direction the next tile will be
		var motion = Vector2i(0, 0)
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
			for i in current_pos.size():
				current_pos[i] = motion + current_pos[i]
			for i in rotation_matrix.size():
				rotation_matrix[i] = motion + rotation_matrix[i]
			centre_vector = motion + centre_vector
			position = tilemap.map_to_local(centre_vector)
		

# receives tilemap to calculate whether an item is staying within confines of bag
func set_world_coords(coords: TileMapLayer):
	tilemap = coords
	
# returns true only if tile exists in pocket layer in specified direction
func is_space_available(motion: Vector2i):
	var do_all_tiles_exist = true
	for cell in current_pos:
		if (!tilemap.get_cell_tile_data(motion + cell)):
			do_all_tiles_exist = false
	return do_all_tiles_exist
		
func select_item():
	is_item_selected = !is_item_selected
	
func set_item_scene(item_scene: Node):
	scene = item_scene
	add_child(scene)
	
#	keeps TileMapLayer invisible - hides the green and red tiles as they are only bts logic
	var scene_tiles = scene.find_child("TileMapLayer")
	scene_tiles.visible = false
	var new_pos = []
	for cell in scene_tiles.get_used_cells_by_id(1, Vector2i(1, 0)):
		new_pos.append(cell + Vector2i(2, 2))
	current_pos = new_pos
	#for cell in scene_tiles.get_used_cells():
		#cell.get_cell_tile_data()
