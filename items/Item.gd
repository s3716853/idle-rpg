class_name Item
extends Resource

@export var item_space = {}
@export var scene:PackedScene

func rotate(item:Node):
	if item_space.size() > 1:
		var x = 1
		var y = 1
#		item_space.size() is interchangeable for x and y because matrix must be a square
		var max = sqrt(item_space.size())
		var swap
		while y <= max:
			#print("y = ", y)
			while x <= max:
				#print("x = ", x)
				swap = item_space[Vector2i(x, y)]
				item_space[Vector2i(x, y)] = item_space[Vector2i(y, x)]
				item_space[Vector2i(y, x)] = swap
				x += 1
			y += 1
			x = y
		x = 1
		y = 1
		while y <= max:
			if x < (max - (x-1)):
				swap = item_space[Vector2i(x, y)]
				item_space[Vector2i(x, y)] = item_space[Vector2i(max, y)]
				item_space[Vector2i(max, y)] = swap
				x += 1
			y += 1
			x = 1
#	rotate item sprite, and reset rotation above 359 to prevent redundancies and ultimately integer overflow
	item.rotation_degrees += 90
	if item.rotation_degrees == 360:
		item.rotation_degrees = 0
	for vector in item_space:
		print(vector, item_space[vector])
	print("\n")
	print(item.rotation_degrees)
