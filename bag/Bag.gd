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
	selected_item.select_item()
	
#	testing resources
	res_scene = res.scene.instantiate()
	add_child(res_scene)
	res_scene.position = tilemap.map_to_local(Vector2i(3, 3))
	
# 	placing item inside the bag using hardcoded vector
	item.position = tilemap.map_to_local(Vector2i(1, 1))
	
# 	creates empty bag
	for cell in tilemap.get_used_cells():
		bag_contents[cell] = null

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	manage_bag()

#	test for resource rotation
	if Input.is_action_just_pressed("ui_cancel"):
		res.rotate(res_scene)
		
#saves item to bag_contents dict when pressing Enter, deletes when pressing Esc
func manage_bag():
	if Input.is_action_just_pressed("ui_accept"):
# 		if there is space in specified area
		var all_cells_free = true
		for cell in selected_item.current_pos:
			if bag_contents[cell] != null:
				all_cells_free = false
		if all_cells_free:
			
# 			creates a new scene and adds to tree
			var bag_item = scene.instantiate()
			add_child(bag_item)
			for cell in selected_item.current_pos:
				bag_contents[cell] = bag_item
				
	# 			sets item's position relative to the bag's local coordinate system, then fades the colour
				bag_item.position = tilemap.map_to_local(selected_item.centre_vector)
				bag_item.modulate = Color(0.8, 0.8, 0.8, 0.8)
				
		else: 
# 			test output to console - there is an item already in the specified area
			print("item already in space")
			
#	deleting items
#	haven't updated to scan through all of current_pos yet, as logically it doesn't quite make sense
# 	as in: in-game, deleting items from the bag would occur in a circumstance where you either use the item,
#	or you are reorganising the bag. in both these circumstances, you aren't holding on to another item
#	at the same time. the cursor could highlight the item you are about to delete so there's an argument
#	for needing to use multiple cells in this conditional, however you aren't comparing an item with another.
# 	so I still need to implement a way to navigate the bag without actually holding an item as it currently is
#	through hardcoded variables up the top of this script. once that's completed, i can forge ahead with
#	refactoring this conditional.
	if Input.is_action_just_pressed("ui_cancel"):
# 		test output to console 
		print("item in space is: ", bag_contents[selected_item.centre_vector])
		
# 		if an item is already in the specified area
		if bag_contents[selected_item.centre_vector] != null:
			
# 			delete scene instance and clear bag's dictionary value
			bag_contents[selected_item.centre_vector].queue_free()
			bag_contents[selected_item.centre_vector] = null
			
func assign_id(item):
	item.set_id(item_id)
	item_id += 1

#i was calling this method every frame... not sure why
#leaving it for now but its deprecated and from what i can tell has no use other than consuming resources
func display_bag():
	for cell in tilemap.get_used_cells():
		if bag_contents[cell] != null:
			bag_contents[cell].position = tilemap.map_to_local(cell)
