extends Node2D

var selected_item
var tilemap: TileMapLayer
var bag_contents = {}
const pocket_layer = 0
var res_scene
var item_id = 0
var cursor
var cursor_pos
const SPEED = 1.0
var last_hovered
var item

@export var res:Item

var item_scene = preload("res://items/BagItem.tscn")
var potion_scene = preload("res://items/Potion.tscn")
var pickaxe_scene = preload("res://items/Pickaxe.tscn")
var cursor_scene = preload("res://items/Cursor.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = $pocket
	
# 	adding in a placeholder item for testing
# 	instanciate item in scene - currently for testing purposes that an item is placed when starting scene
# 	sends tilemap for calculations - need to change this so bag.gd calcs movement instead
	item = item_scene.instantiate()
	item.set_item_scene(pickaxe_scene.instantiate())
	assign_id(item)
	add_child(item)
	selected_item = item
	selected_item.select_item()
	
#	testing resources
	#res_scene = res.scene.instantiate()
	#add_child(res_scene)
	#res_scene.position = tilemap.map_to_local(Vector2i(3, 3))
	
# 	placing item inside the bag using hardcoded vector
	item.position = tilemap.map_to_local(Vector2i(2, 2))
	cursor_pos = Vector2i(1,1)
	
# 	creates empty bag
	for cell in tilemap.get_used_cells():
		bag_contents[cell] = null

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	manage_bag()

##	test for resource rotation
	#if Input.is_action_just_pressed("ui_cancel"):
		#res.rotate(res_scene)
		
#saves item to bag_contents dict when pressing Enter, deletes when pressing Esc
func manage_bag():
	if selected_item:
		var motion = movement()
		#	make sure there is room to move item before updating current_pos
		if is_space_available(motion):
			for i in selected_item.current_pos.size():
				selected_item.current_pos[i] = motion + selected_item.current_pos[i]
			for i in selected_item.rotation_matrix.size():
				selected_item.rotation_matrix[i] = motion + selected_item.rotation_matrix[i]
			selected_item.centre_vector = motion + selected_item.centre_vector
			selected_item.position = tilemap.map_to_local(selected_item.centre_vector)
		if Input.is_action_just_pressed("ui_accept"):
	# 		if there is space in specified area
			var all_cells_free = true
			for cell in selected_item.current_pos:
				if bag_contents[cell] != null:
					all_cells_free = false
			if all_cells_free:

				for cell in selected_item.current_pos:
					bag_contents[cell] = item
					
	# 			sets item's position relative to the bag's local coordinate system, then fades the colour
				item.position = tilemap.map_to_local(selected_item.centre_vector)
				item.modulate = Color(0.7, 0.7, 0.7, 1)
				
				cursor_pos = selected_item.centre_vector
				selected_item.select_item()
				selected_item = null
				manage_cursor()
				cursor.position = tilemap.map_to_local(cursor_pos)
			else: 
	# 			test output to console - there is an item already in the specified area
				print("item already in space")
	else:
#		cursor logic
		var motion = movement()
		
#		checks for pocket layer cell
		if (tilemap.get_cell_tile_data(motion + cursor_pos)):
			cursor_pos = motion + cursor_pos
			cursor.position = tilemap.map_to_local(cursor_pos)
		
		if bag_contents[cursor_pos]:
			bag_contents[cursor_pos].modulate = Color(1, 1, 1, 1)
			last_hovered = bag_contents[cursor_pos]
		else:
			if last_hovered:
				last_hovered.modulate = Color(0.7, 0.7, 0.7, 1)
				last_hovered = null
				
		if Input.is_action_just_pressed("ui_accept"):
			if bag_contents[cursor_pos]:
				selected_item = bag_contents[cursor_pos]
				selected_item.modulate = Color(1, 1, 1, 1)
				selected_item.select_item()
				
				var keys = bag_contents.keys()
				for key in keys:
					if bag_contents[key] != null:
						if bag_contents[key].id == selected_item.id:
							bag_contents[key] = null
				manage_cursor()
		
			
	#	deleting items
	#	haven't updated to scan through all of current_pos yet, as logically it doesn't quite make sense
	# 	as in: in-game, deleting items from the bag would occur in a circumstance where you either use the item,
	#	or you are reorganising the bag. in both these circumstances, you aren't holding on to another item
	#	at the same time. the cursor could highlight the item you are about to delete so there's an argument
	#	for needing to use multiple cells in this conditional, however you aren't comparing an item with another.
	# 	so I still need to implement a way to navigate the bag without actually holding an item as it currently is
	#	through hardcoded variables up the top of this script. once that's completed, i can forge ahead with
	#	refactoring this conditional.
	
		#if Input.is_action_just_pressed("ui_cancel"):
	## 		test output to console 
			#print("item in space is: ", bag_contents[selected_item.centre_vector])
			#
	## 		if an item is already in the specified area
			#if bag_contents[selected_item.centre_vector] != null:
				#
	## 			delete scene instance and clear bag's dictionary value
				#bag_contents[selected_item.centre_vector].queue_free()
				#bag_contents[selected_item.centre_vector] = null
				
				
			
			
func movement():
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
	return motion

func assign_id(item):
	item.set_id(item_id)
	item_id += 1
	
# returns true only if tile exists in pocket layer in specified direction
func is_space_available(motion: Vector2i):
	var do_all_tiles_exist = true
	for cell in selected_item.current_pos:
		if (!tilemap.get_cell_tile_data(motion + cell)):
			do_all_tiles_exist = false
	return do_all_tiles_exist
	
func manage_cursor():
	if cursor:
		print("free cursor")
		cursor.queue_free()
		cursor = null
		cursor_pos = null
	else:
		print("init cursor")
		cursor = cursor_scene.instantiate()
		add_child(cursor)
#		error check - makes sure cursor has a default position
		if !cursor_pos:
			cursor.position = tilemap.map_to_local(Vector2i(1, 1))
			cursor_pos = Vector2i(1, 1)

#i was calling this method every frame... not sure why
#leaving it for now but its deprecated and from what i can tell has no use other than consuming resources

#potentially a future function that would be used when loading in saved data or something similar
func display_bag():
	for cell in tilemap.get_used_cells():
		if bag_contents[cell] != null:
			bag_contents[cell].position = tilemap.map_to_local(cell)
