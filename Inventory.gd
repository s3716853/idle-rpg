extends Node

const InventoryItem = preload("res://InventoryItem.gd")
var inventoryItems = []
signal inventory_update

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hello():
	print("HELLO")
	
func add_item(name, quantity):
	print("adding new item")
	inventoryItems.append(InventoryItem.new(name, quantity))
	inventory_update.emit()
