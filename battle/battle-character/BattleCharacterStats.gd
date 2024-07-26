extends Resource

@export var physical: int
@export var magic: int
@export var luck: int
@export var agility: int

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_physical = 0, p_magic = 0, p_luck = 0, p_agility = 0):
	physical = p_physical
	magic = p_magic
	luck = p_luck
	agility = p_agility

static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacterStats.gd").new()
	instance.physical = dictionary["physical"]
	instance.magic = dictionary["magic"]
	instance.luck = dictionary["luck"]
	instance.agility = dictionary["agility"]
	return instance
