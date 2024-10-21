extends Node2D

var selected_item
var tilemap: TileMap
var bag_contents = {}
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
	
	var cells = tilemap.get_used_cells(0)
	for cell in cells:
		bag_contents[cell] = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#saves item to bag_contents dict when pressing Enter, deletes when pressing Esc
	if Input.is_action_just_pressed("ui_accept"):
		if bag_contents[selected_item.current_pos] == null:
			bag_contents[selected_item.current_pos] = selected_item
		else: 
			print(bag_contents[selected_item.current_pos])
	if Input.is_action_just_pressed("ui_cancel"):
		print(bag_contents[selected_item.current_pos])
		if bag_contents[selected_item.current_pos] != null:
			bag_contents[selected_item.current_pos] = null
		
