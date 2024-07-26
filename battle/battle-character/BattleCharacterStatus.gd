extends Resource

@export var health: int
@export var mana: int
@export var effects: Array
@export var buffs: Array

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_health = 0, p_mana = 0, p_effects = [], p_buffs = []):
	health = p_health
	mana = p_mana
	effects = p_effects
	buffs = p_buffs

static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacterStatus.gd").new()
	instance.health = dictionary["health"]
	instance.mana = dictionary["mana"]
	return instance
