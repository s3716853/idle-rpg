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

func reduce_health(amount = 0):
	health = health - amount
	return health

func reduce_mana(amount = 0):
	mana = mana - amount
	return mana
	
# Passing maximum as null could be used for overheal
func increase_health(amount = 0, maximum = null):
	health = health + amount
	if(maximum != null && health > maximum):
		health = maximum
	return health
	
# Passing maximum as null could be used for overmana
func increase_mana(amount = 0, maximum = null):
	mana = mana + amount
	if(maximum != null && mana > maximum):
		mana = maximum
	return mana
	
func add_effect(effect):
	effects.append((effect))
	return effects
	
func add_buff(buff):
	buffs.append((buff))
	return buffs

static func from_dict(dictionary: Dictionary):
	var instance = load("res://battle/battle-character/BattleCharacterStatus.gd").new()
	instance.health = dictionary["health"]
	instance.mana = dictionary["mana"]
	return instance
