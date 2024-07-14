extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	update_content()
	Inventory.inventory_update.connect(update_content)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func update_content():
	var text_content = ""
	for item in Inventory.inventoryItems:
		var item_name = item.item_name
		var quantity = item.quantity
		text_content += "{name} - {quantity}".format({"name": item_name, "quantity": quantity})
	text = text_content
	print(text)
