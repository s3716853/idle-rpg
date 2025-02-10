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

func _physics_process(_delta):
	pass
		
func select_item():
	is_item_selected = !is_item_selected
	
func set_item_scene(item_scene: Node):
	scene = item_scene
	add_child(scene)
	
#	keeps TileMapLayer invisible - hides the green and red tiles as they are only bts logic
	var scene_tile_layer = scene.find_child("TileMapLayer")
	scene_tile_layer.visible = false
	
#	updates current_pos by collecting all cells that are green in the TileMapLayer of the scene
	var new_pos = []
	var scene_tiles = scene_tile_layer.get_used_cells()
	
#	sorts all tiles in the tile layer from top-left to bottom-right
#	then calculates the difference between the bag's top-left tile and the item's top-left tile
#	the difference will always be at least (1, 1), which is the bag's top-left tile
#	and will increase 1:1 with the distance between the centre and border of an item
#	ergo diff represents the centre of the item when it is pressed against the top-left corner of the bag
	scene_tiles.sort()
	print(scene_tiles)
	var diff = Vector2i(1,1) - scene_tiles.front()
	centre_vector = diff
	print(diff)
	
#	only finds the green tiles, and updates current_pos accordingly
	for cell in scene_tile_layer.get_used_cells_by_id(1, Vector2i(1, 0)):
		new_pos.append(cell + diff)
	current_pos = new_pos
