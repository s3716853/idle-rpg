extends Resource
class_name BattleMove

enum TARGETS {SELF, ENEMY, FRIEND}
enum TYPES {ATTACK_PHSY, ATTACK_MAG, STATUS, STAT, SUPPORT}

static func use(user : BattleCharacterController, target : BattleCharacterController,  player: BattleCharacterController, party):
	assert(false, "UNDEFINED FUNCTION use");

static func info():
	assert(false, "UNDEFINED FUNCTION info")
