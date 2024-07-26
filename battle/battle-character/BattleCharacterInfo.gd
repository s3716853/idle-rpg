extends Resource

@export var name: String
@export var description: String

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_name = "", p_description = ""):
	name = p_name
	description = p_description

static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacterInfo.gd").new()
	instance.name = dictionary["name"]
	instance.description = dictionary["description"]
	return instance
