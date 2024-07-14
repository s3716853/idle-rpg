extends Node2D

var enemy_data = null
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	load_enemy_data()
	load_current_battle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func load_enemy_data():
	var file = FileAccess.open("res://resources/enemies.json", FileAccess.READ)
	var content = file.get_as_text()
	enemy_data = JSON.parse_string(content)
	
func load_current_battle():
	#var my_random_number = rng.randf_range(1, 1)
	print(enemy_data)
