extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
# adding in a placeholder item for testing
	var scene = preload("res://items/BagItem.tscn")
	var item = scene.instantiate()
	add_child(item)
	var tilemap = $TileMap
	
#placing item inside the bag using hardcoded vector
	item.position = tilemap.map_to_local(Vector2i(1, 1))
	#print(tilemap.get_surrounding_cells(Vector2i(1, 1)))
	#item.position.x = 0
	#item.position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
