extends Node2D

var enemy_data = null
var rng = RandomNumberGenerator.new()
var enemies = []
var friends = []

# Called when the node enters the scene tree for the first time.
func _ready(): 
	load_enemy_data()
	load_current_battle()
	load_enemy_sprites()
	prepare_listeners()
	display_current_battle()

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
	var enemy = BattleCharacterController.new()
	enemy.battle_character = BattleCharacter.from_dict(enemy_data["snake-s"])
	enemy.battle_character_assets = BattleCharacterAssets.from_dict(enemy_data["snake-s"]["assets"])
	enemies.append(enemy)

func prepare_listeners():
	for enemy : BattleCharacterController in enemies:
		enemy.health_change.connect(on_health_change)
		enemy.mana_change.connect(on_health_change)
		
func on_health_change(battle_character, before, after):
	if(before < after):
		print("Hurt")
	elif(before > after):
		print("Healed")
	else: 
		print("This shouldn't happen")
	print(battle_character)
	
func on_mana_change(battle_character, before, after):
	if(before < after):
		print("Hurt")
	elif(before > after):
		print("Healed")
	else: 
		print("This shouldn't happen")
	print(battle_character)

func load_enemy_sprites():
#TODO this whole function lol 
	var enemy_sprite : AnimatedSprite2D = get_node("Enemy_Container/Enemy_Sprite_01")
	var sprite_resource : SpriteFrames
	for enemy : BattleCharacterController in enemies:
		sprite_resource = enemy.get_sprite_resource(BattleCharacterAssets.sprite_types.MAIN)
	enemy_sprite.sprite_frames = sprite_resource
	
func display_current_battle():
	var enemy_sprite : AnimatedSprite2D = get_node("Enemy_Container/Enemy_Sprite_01")
	enemy_sprite.animation= "idle"
	enemy_sprite.play()
