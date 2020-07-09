extends "Character.gd"

var attack
var character_name = 'Unset'
var item_distribution
var base_damage = 1
var processBehaviour
var turnBehaviour
var previous_stand_direction = Enums.DIRECTION.DOWN
var undamageableAnimationName = ""

func _enter_tree():
	GameData.characters.append(self)
	
func _ready():
	set_process(true)
	self.get_node("/root/Node2D").connectEnemy(self)
	trapImmune = true
	._ready()

func attack(character, isFirstCollision, damage=0):
	.attack(character, isFirstCollision, base_damage);

func turn(skipTurnBehaviour = false):
	turnWithNoAfterMoveComplete(skipTurnBehaviour)
	
	afterMoveComplete()

func turnWithNoAfterMoveComplete(skipTurnBehaviour = false):
	if stunnedDuration <= 0:
		if movement_direction != Enums.DIRECTION.NONE:
			previous_stand_direction = movement_direction
		
		if !skipTurnBehaviour:
			moving = moveDirection(turnBehaviour.turn(original_pos))
	
	.turn()

func afterMoveComplete():
	turnBehaviour.afterMoveComplete(turn_end_pos)
	
	.afterMoveComplete()

func setTurnAnimations():
	if moving:
		if movement_direction != Enums.DIRECTION.NONE:
			setWalkAnimation(movement_direction)
		else:
			setStandAnimation(previous_stand_direction)

func _process(delta):
	#state = new position, new moving
	var state = processBehaviour.getNewState(get_position(), original_pos, movement_direction, moving, delta)
	
	if state[0] != null:
		self.set_position(state[0])
	
	if self.moving and !state[1]:
		original_pos = get_position()
		
		if stand_direction != Enums.DIRECTION.NONE:
			self.set_position(turn_end_pos)
			setStandAnimation(stand_direction)
		else:
			setStandAnimation(previous_stand_direction)
	
	if state[1] != null:
		self.moving = state[1]

func handleCharacterDeath():
	dropItem()
	GameData.player_kills += 1
	.handleCharacterDeath()

func dropItem():
	if(item_distribution != null):
		for pickedItem in item_distribution.pick():
			var item = pickedItem.value.new()
			item.place(target_pos)

func setWalkAnimation(direction):
	if (!damageable and undamageableAnimationName != ""):
		setAnimationOnAllBodyParts(undamageableAnimationName)
	else:
		.setWalkAnimation(direction)

func setStandAnimation(direction):
	if (!damageable and undamageableAnimationName != ""):
		setAnimationOnAllBodyParts(undamageableAnimationName)
	else:
		.setStandAnimation(direction)

func addStun(turnAmount):
	if turnAmount <= 0:
		return
	
	.addStun(turnAmount)
	get_node("Stars").show()

func removeStunned():
	.removeStunned()
	get_node("Stars").hide()

func setBaseDamage(baseDamage, difficultyIncrease = 0.5):
	base_damage = baseDamage + difficultyIncrease * GameData.currentDifficultyUndeadCrypt

func setInitialHealth(healthStat, maxHealthStat, difficultyIncrease = 0.75):
	if !fixedMaxHealth:
		healthStat += difficultyIncrease * GameData.currentDifficultyUndeadCrypt
		maxHealthStat += difficultyIncrease * GameData.currentDifficultyUndeadCrypt
	
	initialStats.health = {
		"value": healthStat,
		"maximum": maxHealthStat
	}

func setInitialStats(strengthStat, maxStrengthStat, defenceStat, maxDefenceStat, difficultyIncrease = 0.75):
	strengthStat += difficultyIncrease * GameData.currentDifficultyUndeadCrypt
	maxStrengthStat += difficultyIncrease * GameData.currentDifficultyUndeadCrypt
	defenceStat += difficultyIncrease * GameData.currentDifficultyUndeadCrypt
	maxDefenceStat += difficultyIncrease * GameData.currentDifficultyUndeadCrypt

	initialStats.strength = {
		"value": strengthStat,
		"maximum": maxStrengthStat
	}

	initialStats.defence = {
		"value": defenceStat,
		"maximum": maxDefenceStat
	}
