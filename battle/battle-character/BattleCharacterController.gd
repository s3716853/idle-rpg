extends Node
class_name BattleCharacterController

var battle_character : BattleCharacter
var battle_character_assets : BattleCharacterAssets

signal health_change
signal mana_change
signal character_death
signal character_revive

func _init(p_battle_character = BattleCharacter.new(), p_battle_character_assets = BattleCharacterAssets.new()):
	battle_character = p_battle_character
	battle_character_assets = p_battle_character_assets

func take_damage(amount: int):
	var health_before = battle_character.battleCharacterStatus.health
	var alive = battle_character.take_damage(amount)
	var health_after = battle_character.battleCharacterStatus.health
	health_change.emit(battle_character, health_before, health_after)
	if (!alive):
		character_death.emit(battle_character)

func heal(amount : int):
	var health_before = battle_character.battleCharacterStatus.health
	battle_character.heal(amount)
	var health_after = battle_character.battleCharacterStatus.health
	health_change.emit(battle_character, health_before, health_after)

func use_mana(amount: int):
	var mana_before = battle_character.battleCharacterStatus.mana
	battle_character.use_mana(amount)
	var mana_after = battle_character.battleCharacterStatus.mana
	mana_change.emit(battle_character, mana_before, mana_after)
	
func replenish_mana(amount: int):
	var mana_before = battle_character.battleCharacterStatus.mana
	battle_character.replenish_mana(amount)
	var mana_after = battle_character.battleCharacterStatus.mana
	mana_change.emit(battle_character, mana_before, mana_after)
	
func get_sprite_resource(sprite_type: BattleCharacterAssets.sprite_types):
	return load(battle_character_assets.get_sprite(sprite_type))
	
func get_moves():
	var moves = []
	for move in battle_character.move_bag:
		var move_resource_string = "res://battle/moves/%s.gd" % move
		var move_object = load("res://battle/moves/%s.gd" % move)
		moves.append(move_object)
	return moves
	
func info():
	return {
		"name": battle_character.battleCharacterInfo.name
	}
