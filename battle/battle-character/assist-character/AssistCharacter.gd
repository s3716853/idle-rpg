extends BattleCharacter
class_name AssistCharacter

var move_bag: Array[String]

func _init(p_battleCharacterInfo = BattleCharacterInfo.new(), p_battleCharacterStats = BattleCharacterStats.new(), p_battleCharacterStatus = BattleCharacterStatus.new(), p_move_bag = []):
	move_bag = p_move_bag
	super(p_battleCharacterInfo, p_battleCharacterStats, p_battleCharacterStatus)
	
static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/PlayerCharacter.gd").new()
	instance.battleCharacterInfo = BattleCharacterInfo.from_dict(dictionary["info"])
	instance.battleCharacterStats = BattleCharacterStats.from_dict(dictionary["stats"])
	instance.battleCharacterStatus = BattleCharacterStatus.from_dict(dictionary["status"])
	instance.move_bag = dictionary["move_bag"]
	return instance
