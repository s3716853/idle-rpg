extends Resource
class_name BattleMove
const BattleCharacterController = preload("res://battle/battle-character/BattleCharacterController.gd")

enum TARGETS {SELF, ENEMY, FRIEND}
enum TYPES {ATTACK_PHSY, ATTACK_MAG, STATUS, STAT, SUPPORT}

static func use(user : BattleCharacterController, target : BattleCharacterController,  player: BattleCharacterController, party: Array[BattleCharacterController]):
	assert(false, "UNDEFINED FUNCTION use");

static func info():
	assert(false, "UNDEFINED FUNCTION info")
