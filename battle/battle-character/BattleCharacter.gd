extends Resource
class_name BattleCharacter

const BattleCharacterInfo = preload("res://battle/battle-character/BattleCharacterInfo.gd")
const BattleCharacterStats = preload("res://battle/battle-character/BattleCharacterStats.gd")
const BattleCharacterStatus = preload("res://battle/battle-character/BattleCharacterStatus.gd")

var battleCharacterInfo: BattleCharacterInfo
var battleCharacterStats: BattleCharacterStats
var battleCharacterStatus: BattleCharacterStatus

var alive : bool

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_battleCharacterInfo = BattleCharacterInfo.new(), p_battleCharacterStats = BattleCharacterStats.new(), p_battleCharacterStatus = BattleCharacterStatus.new()):
	battleCharacterInfo = p_battleCharacterInfo
	battleCharacterStats = p_battleCharacterStats
	battleCharacterStatus = p_battleCharacterStatus
	alive = true
	
func take_damage(amount: int):
	var health = battleCharacterStatus.reduce_health(amount)
	if (health <= 0):
		alive = false
	return alive
	
func heal(amount: int):
	battleCharacterStatus.increase_health(amount, battleCharacterStats.max_health)
	
func use_mana(amount: int):
	battleCharacterStatus.reduce_mana(amount)

func replenish_mana(amount: int):
	battleCharacterStatus.increase_mana(amount, battleCharacterStats.max_mana)
	
static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacter.gd").new()
	instance.battleCharacterInfo = BattleCharacterInfo.from_dict(dictionary["info"])
	instance.battleCharacterStats = BattleCharacterStats.from_dict(dictionary["stats"])
	if(dictionary.has("status")):
		instance.battleCharacterStatus = BattleCharacterStatus.from_dict(dictionary["status"])
	return instance

