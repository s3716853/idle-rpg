extends Resource

const BattleCharacterInfo = preload("res://battle/battle-character/BattleCharacterInfo.gd")
const BattleCharacterStats = preload("res://battle/battle-character/BattleCharacterStats.gd")
const BattleCharacterStatus = preload("res://battle/battle-character/BattleCharacterStatus.gd")

var battleCharacterInfo: BattleCharacterInfo
var battleCharacterStats: BattleCharacterStats
var battleCharacterStatus: BattleCharacterStatus

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_battleCharacterInfo = BattleCharacterInfo.new(), p_battleCharacterStats = BattleCharacterStats.new(), p_battleCharacterStatus = BattleCharacterStatus.new()):
	battleCharacterInfo = p_battleCharacterInfo
	battleCharacterStats = p_battleCharacterStats
	battleCharacterStatus = p_battleCharacterStatus

static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacter.gd").new()
	instance.battleCharacterInfo = BattleCharacterInfo.from_dict(dictionary["info"])
	instance.battleCharacterStats = BattleCharacterStats.from_dict(dictionary["stats"])
	instance.battleCharacterStatus = BattleCharacterStatus.from_dict(dictionary["status"])
	return instance

