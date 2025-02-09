extends CharacterBody2D

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

func _physics_process(delta):
	pass
		
func select_item():
	is_item_selected = !is_item_selected
	
func set_item_scene(item_scene: Node):
	scene = item_scene
	add_child(scene)
	
#	keeps TileMapLayer invisible - hides the green and red tiles as they are only bts logic
	var scene_tiles = scene.find_child("TileMapLayer")
	scene_tiles.visible = false
	
#	updates current_pos by collecting all cells that are green in the TileMapLayer of the scene
	var new_pos = []
	for cell in scene_tiles.get_used_cells_by_id(1, Vector2i(1, 0)):
		new_pos.append(cell + Vector2i(2, 2))
	current_pos = new_pos
