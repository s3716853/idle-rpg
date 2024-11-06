class_name Item
extends Resource

@export var item_space = {}

func rotate():
	if item_space.size() > 1:
		var x = 1
		var y = 1
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
	
	#for vector in item_space:
		#print(vector, item_space[vector])
	#print("\n")
