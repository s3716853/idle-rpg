extends Node2D

const BattleCharacter = preload("res://battle/battle-character/BattleCharacter.gd")

var enemy_data = null
var rng = RandomNumberGenerator.new()
var enemies = []
var friends = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_enemy_data()
	load_current_battle()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func load_enemy_data():
	# Idea: Have one base enemies.json that is split into enemy-{id}.json files by a python script. 
	# Gives us something easy to modify as a single source of truth, without causing the whole 
	# json to be read
	var file = FileAccess.open("res://resources/enemies.json", FileAccess.READ)
	var content = file.get_as_text()
	enemy_data = JSON.parse_string(content)
	
func load_current_battle():
	#var my_random_number = rng.randf_range(1, 1)
	print(enemy_data["snake-s"])
	var enemy = BattleCharacter.from_dict(enemy_data["snake-s"])
	enemies.append(enemy)
	print(enemies)
