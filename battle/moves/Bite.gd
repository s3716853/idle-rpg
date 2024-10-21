extends BattleMove

static func use(user : BattleCharacterController, target : BattleCharacterController,  player: BattleCharacterController, party):
	var damage = calculate_damage(user, target)
	target.take_damage(damage)
	
#TODO implement damage cal based on stats
static func calculate_damage(user : BattleCharacterController, target : BattleCharacterController):
	return 10
	
static func info():
	return {
		"name": "Bite",
		"description": "Deal damage to the enemy and increase own attck by 1",
		"type": TYPES.ATTACK_PHSY,
		"targets": TARGETS.ENEMY,
		"accuracy": 100,
		"value": 10
	}
