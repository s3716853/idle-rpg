extends BattleCharacter
class_name PlayerCharacter

var morale : int
var max_morale : int
var morale_empty : bool

func _init(p_battleCharacterInfo = BattleCharacterInfo.new(), p_battleCharacterStats = BattleCharacterStats.new(), p_battleCharacterStatus = BattleCharacterStatus.new(), p_morale = 0, p_max_morale = 0):
	morale = p_morale
	max_morale = p_max_morale
	morale_empty = false
	super(p_battleCharacterInfo, p_battleCharacterStats, p_battleCharacterStatus)

func lose_morale(amount: int):
	morale = morale - amount
	if(morale <= 0):
		morale_empty = true
	return morale_empty

func gain_morale(amount: int, maximum = null):
	morale = morale + amount
	if(maximum != null && morale > maximum):
		morale = maximum
	return morale
	
static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/PlayerCharacter.gd").new()
	instance.battleCharacterInfo = BattleCharacterInfo.from_dict(dictionary["info"])
	instance.battleCharacterStats = BattleCharacterStats.from_dict(dictionary["stats"])
	instance.battleCharacterStatus = BattleCharacterStatus.from_dict(dictionary["status"])
	instance.morale = dictionary["status"]["morale"]
	instance.max_morale = dictionary["stats"]["max_morale"]
	return instance
