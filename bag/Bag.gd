extends Node2D

var selected_item
var tilemap: TileMapLayer
var bag_contents = {}
const pocket_layer = 0
var res_scene
var item_id = 0

@export var res:Item

var scene = preload("res://items/BagItem.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = $pocket
	
# 	adding in a placeholder item for testing
# 	instanciate item in scene - currently for testing purposes that an item is placed when starting scene
# 	sends tilemap for calculations - need to change this so bag.gd calcs movement instead
	var item = scene.instantiate()
	item.set_world_coords(tilemap)
	assign_id(item)
	add_child(item)
	selected_item = item
	
#	testing resources
	res_scene = res.scene.instantiate()
	add_child(res_scene)
	res_scene.position = tilemap.map_to_local(Vector2i(3, 3))
	
# 	placing item inside the bag using hardcoded vector
	item.position = tilemap.map_to_local(Vector2i(1, 1))
	
# 	creates empty bag
	for cell in tilemap.get_used_cells():
		bag_contents[cell] = null

func assign_id(item: Node):
	item.set_id(item_id)
	item_id += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#saves item to bag_contents dict when pressing Enter, deletes when pressing Esc
	if Input.is_action_just_pressed("ui_accept"):
# 		if there is space in specified area
		if bag_contents[selected_item.current_pos] == null:
			
# 			creates a new scene and adds to tree
			bag_contents[selected_item.current_pos] = scene.instantiate()
			add_child(bag_contents[selected_item.current_pos])
			
# 			sets item's position relative to the bag's local coordinate system, then fades the colour
			bag_contents[selected_item.current_pos].position = tilemap.map_to_local(selected_item.current_pos)
			bag_contents[selected_item.current_pos].modulate = Color(0.8, 0.8, 0.8, 0.8)
			
		else: 
# 			test output to console - there is an item already in the specified area
			print("item already in space: ", bag_contents[selected_item.current_pos])
			
	if Input.is_action_just_pressed("ui_cancel"):
# 		test output to console 
		print("item in space is: ", bag_contents[selected_item.current_pos])
		
# 		if an item is already in the specified area
		if bag_contents[selected_item.current_pos] != null:
			
# 			delete scene instance and clear bag's dictionary value
			bag_contents[selected_item.current_pos].queue_free()
			bag_contents[selected_item.current_pos] = null
			
#	test for resource rotation
	if Input.is_action_just_pressed("ui_cancel"):
		res.rotate(res_scene)
		
#i was calling this method every frame... not sure why
#leaving it for now but its deprecated and from what i can tell has no use other than consuming resources
func display_bag():
	for cell in tilemap.get_used_cells():
		if bag_contents[cell] != null:
			bag_contents[cell].position = tilemap.map_to_local(cell)
