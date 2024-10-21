extends Node2D

var selected_item
var tilemap: TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
# adding in a placeholder item for testing
	tilemap = $TileMap
#instanciate item in scene - currently for testing purposes that an item is placed when starting scene
	var scene = preload("res://items/BagItem.tscn")
#instanciates an instance of an item and sends tilemap for calculations
	var item = scene.instantiate()
	item.set_world_coords(tilemap)
	add_child(item)
	selected_item = item
	
#placing item inside the bag using hardcoded vector
	item.position = tilemap.map_to_local(Vector2i(1, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#attempting to save item to tilemap
	if Input.is_action_just_pressed("ui_accept"):
		var data = tilemap.get_cell_tile_data(0, selected_item.current_pos)
		if data.get_custom_data("items") == null:
			data.set_custom_data("items", selected_item)
		else: 
			print(data.get_custom_data("items"))
	if Input.is_action_just_pressed("ui_cancel"):
		var datas = tilemap.get_cell_tile_data(0, selected_item.current_pos)
		print(datas.get_custom_data("items"))
