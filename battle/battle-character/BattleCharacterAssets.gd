extends Resource
class_name BattleCharacterAssets

enum sound_types {ENTRY, EXIT, HIT, ACTION}
enum sprite_types {MAIN}

var sprites : Dictionary
var sounds : Dictionary

func _init(p_sprite_main = null, p_sound_entry = null, p_sound_exit = null, p_sound_action = null, p_sound_hit = null):
	sprites = Dictionary()
	sprites[sprite_types.MAIN] = p_sprite_main
	sounds = Dictionary()
	sounds[sound_types.ENTRY] = p_sound_entry
	sounds[sound_types.EXIT] = p_sound_exit
	sounds[sound_types.ACTION] = p_sound_action
	sounds[sound_types.HIT] = p_sound_hit
	
func get_sprite(sprite_type: sprite_types):
	return sprites[sprite_type]

static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacterAssets.gd").new()
	instance.sprites = Dictionary()
	instance.sprites[instance.sprite_types.MAIN] = dictionary["sprites"]["main"]
	instance.sounds = Dictionary()
	instance.sounds[instance.sound_types.ENTRY] = dictionary["sounds"]["entry"]
	instance.sounds[instance.sound_types.EXIT] = dictionary["sounds"]["exit"]
	instance.sounds[instance.sound_types.ACTION] = dictionary["sounds"]["action"]
	instance.sounds[instance.sound_types.HIT] = dictionary["sounds"]["hit"]
	return instance
