extends Node2D

signal attack(character, amount)

var moving = false
var movement_direction = Enums.DIRECTION.NONE
var stand_direction = Enums.DIRECTION.NONE
var original_pos = get_position()
var target_pos = get_position()
var turn_end_pos = get_position()
var damageable = true
var initial_pos
var isPartOfBossRoom
var environmentsAtTargetPosition = []
var environmentsAtPosition = []

var damageMultiplier = 2
var multiplierRemainingAttacks = 0

var invisible = false
var invisibilityTurnsRemaining = -1

var temporaryMaxHeathTurnsRemaining = -1
var healthAfterTemporaryIncreaseAdded = 0
var temporaryMaxHeathAmount = 2
var damageSinceTemporaryHealthAdded = 0

var temporaryStrengthTurnsRemaining = -1
var temporaryStrengthAmount = 5

var temporaryDefenceTurnsRemaining = -1
var temporaryDefenceAmount = 5
var trapImmune

var fixedMaxHealth

var stunnedDuration

const bodyPartsNodeName = "ChangingBodyParts"

var initialStats = {
	"health": {
		"value": 3,
		"maximum": 3
	},
	"mana": {
		"value": 3,
		"maximum": 3
	},
	"strength": {
		"value": 3,
		"maximum": 3
	},
	"defence": {
		"value": 3,
		"maximum": 3
	}
}

var stats = {
	"health": {},
	"mana": {},
	"strength": {},
	"defence": {}
}

var additionalRelativeAttackPositions = []
var attackPositionBlockable = true
var onlyAttacksFirstEnemy = true

const Hitmarker = preload("res://Characters/Hitmarker.tscn")

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()

func _ready():
	setPosition(get_position())
	
	stunnedDuration = -1
	
	resetStats()

func resetStats():
	var additional = 0
	var additionalHealth = 0

	if self != GameData.player: 
		additional = ceil(GameData.current_level / 2 - 1)

	if !self.fixedMaxHealth: 
		additionalHealth = additional
	
	stats.health = {
		"value" : initialStats.health.value + additionalHealth,
		"maximum" : initialStats.health.maximum + additionalHealth
	}

	stats.mana = {
		"value" : initialStats.mana.value + additional,
		"maximum" : initialStats.mana.maximum + additional
	}

	stats.strength = {
		"value" : initialStats.strength.value + additional,
		"maximum" : initialStats.strength.maximum + additional
	}

	stats.defence = {
		"value" : initialStats.defence.value + additional,
		"maximum" : initialStats.defence.maximum + additional
	}

func afterMoveComplete():
	if stunnedDuration > 0:
		stunnedDuration -= 1
	elif stunnedDuration == 0:
		removeStunned()

func turn(skipTurnBehaviour = false):
	if invisibilityTurnsRemaining > 0:
		invisibilityTurnsRemaining -= 1
	elif invisibilityTurnsRemaining == 0:
		removeInvisibility()

	if temporaryMaxHeathTurnsRemaining > 0:
		temporaryMaxHeathTurnsRemaining -= 1
	elif temporaryMaxHeathTurnsRemaining == 0:
		removeTemporaryMaxHealth()

	if temporaryStrengthTurnsRemaining > 0:
		temporaryStrengthTurnsRemaining -= 1
	elif temporaryStrengthTurnsRemaining == 0:
		removeTemporaryStrength()

	if temporaryDefenceTurnsRemaining > 0:
		temporaryDefenceTurnsRemaining -= 1
	elif temporaryDefenceTurnsRemaining == 0:
		removeTemporaryDefence()

func setTurnAnimations():
	pass

func consume_stat(stat, amount):
	if stats[stat].value >= amount:
		stats[stat].value -= amount
		return true
	return false

func heal(amount, evenIfDead = false):
	increaseHealth(amount, evenIfDead)

func decreaseHealth(amount):
	if self.stats.health.value > 0:
		self.stats.health.value = max(self.stats.health.value - amount, 0)

func increaseHealth(amount, evenIfDead = false):
	if self.stats.health.value < self.stats.health.maximum && (evenIfDead || alive()):
		self.stats.health.value = min(self.stats.health.value + amount, self.stats.health.maximum)

func increaseMana(amount):
	if self.stats.mana.value < self.stats.mana.maximum:
		self.stats.mana.value = min(self.stats.mana.value + amount, self.stats.mana.maximum)

func increaseStat(stat, amount):
	self.stats[stat].value += amount
	self.stats[stat].maximum += amount

func moveDirection(direction):
	if (not moving) and alive():
		original_pos = get_position()
		movement_direction = Enums.DIRECTION.NONE
		stand_direction = Enums.DIRECTION.NONE
		
		if direction != Enums.DIRECTION.NONE:
			movement_direction = handleMove(direction)
			stand_direction = movement_direction
		
		setTarget(movement_direction)
		moving = true
		
		return true

func handleForcedMoveTo(pos):
	var blockedByTile = !targetWalkable(pos)
	
	if blockedByTile:
		target_pos = original_pos
		return false
	
	var blockedByEnvironment = !handleEnvironmentCollisions(pos)
	
	if blockedByEnvironment:
		target_pos = original_pos
		return false

	var blockedByCharacter = GameData.charactersAtPosExcludingCharacter(pos, self).size() > 0

	if blockedByCharacter:
		target_pos = original_pos
		return false
	
	environmentOnWalkedOut()
	position = pos * GameData.TileSize
	original_pos = pos * GameData.TileSize
	turn_end_pos = pos * GameData.TileSize
	
	return true

func handleForcedMove(direction):
	var pos = setTarget(direction)
	
	return handleForcedMoveTo(pos)

func handleMove(direction):
	faceDirection(direction)
	
	var pos = setTarget(direction)
	var attacking = handleEnemyCollisions(PositionHelper.absoluteAttackPositions(pos, additionalRelativeAttackPositions, direction))
	
	if not attacking:
		var walkableEnvironment = handleEnvironmentCollisions(pos)

		if walkableEnvironment:
			if targetWalkable(pos):
				turn_end_pos = pos * GameData.TileSize;
				setWalkAnimation(direction)

				environmentOnWalkedOut()
				
				return direction
			else:
				return Enums.DIRECTION.NONE
	
	return Enums.DIRECTION.NONE

func environmentOnWalkedOut():
	for i in range(environmentsAtPosition.size()):
		if (is_instance_valid(environmentsAtPosition[i])):
			if funcref(environmentsAtPosition[i], "onWalkedOut"):
				environmentsAtPosition[i].onWalkedOut(self)
	
	environmentsAtPosition = environmentsAtTargetPosition
	environmentsAtTargetPosition = []

func setPosition(pos):
	original_pos = pos
	target_pos = pos
	turn_end_pos = pos
	initial_pos = pos

func faceDirection(direction):
	if alive():
		match direction:
			Enums.DIRECTION.UP:
				setAnimationOnAllBodyParts("stand_up")
			Enums.DIRECTION.DOWN:
				setAnimationOnAllBodyParts("stand_down")
			Enums.DIRECTION.LEFT:
				setAnimationOnAllBodyParts("stand_left")
			Enums.DIRECTION.RIGHT:
				setAnimationOnAllBodyParts("stand_right")

func setTarget(direction):
	var pos = original_pos
	pos.x = int(pos.x / GameData.TileSize)
	pos.y = int(pos.y / GameData.TileSize)
	pos = PositionHelper.getNextTargetPos(pos, direction)
	target_pos = pos
	target_pos.x *= GameData.TileSize
	target_pos.y *= GameData.TileSize
	
	return pos

func handleEnemyCollisions(posArray):
	var collisions = []
	var collided = false
	var isFirstCollision = true
	
	for pos in posArray:
		if attackPositionBlockable and (not targetWalkable(pos) or GameData.environmentBlocksAttack(pos)) :
			break;
		
		collisions += GameData.charactersAtPos(pos)

	for collision in collisions:
		if not (collision == self):
			attack(collision, isFirstCollision)
			collided = true
			isFirstCollision = false

			if onlyAttacksFirstEnemy:
				return true
	
	return collided

func handleEnvironmentCollisions(pos):
	var walkable = true
	var collisions = GameData.environmentObjectAtPos(pos)
	var isPlayer = self == GameData.player
	
	for i in range(collisions.size()):
		if collisions[i].walkable == Enums.WALKABLE.NONE or (collisions[i].walkable == Enums.WALKABLE.PLAYER && !isPlayer) :
			walkable = false
		
		collisions[i].onWalkedInto(self)
		environmentsAtTargetPosition.append(collisions[i])
		
	return walkable

func sample_normal_distribution(mean, sd):
	# Use the Box-Muller transform to sample from the given normal distribution.
	# https://en.wikipedia.org/wiki/Box-Muller_transform
	return sqrt(-2 * log(randf())) * cos(2 * PI * randf()) * sd + mean

func calculate_damage(character, base_damage):
	# Get the stats to use for the roll
	var attack = self.stats.strength.value
	var defence = character.stats.defence.value
	# Calculate the absolute (i.e. always positive) difference in stats.
	var difference = abs(attack - defence)
	# Calculate the sign (i.e. positive or negative) of the difference in stats.
	var difference_sign
	if attack >= defence:
		difference_sign = 1
	else:
		difference_sign = -1
	
	# The mean of the distribution is 0 by default.
	var mean = 0
	if difference > 1:
		mean = float(difference_sign) / 4 * (pow(difference, 1.1) - 1)
 
	# Use a fixed standard deviation. The value 1.1 gives a 10% chance of getting
	# a modifier of 0 or 2 for equal stats (i.e. a difference of 0).
	var sd = 1.2
	
	# Generate a random number, between -infinity and infinity, from the standard
	# distribution with calculated mean and standard deviation.
	var modifier = sample_normal_distribution(mean, sd)
	
	# Case statement to convert the number to one of the modifier values, 0, 0.5,
	# 1, 1.5, or 2.
	if modifier < -2:
		modifier = 0
	elif modifier < -1:
		modifier = 0.5
	elif modifier < 1:
		modifier = 1
	elif modifier < 2:
		modifier = 1.5
	else:
		modifier = 2
	
	return base_damage * modifier

func shouldAttack(character):
	return alive() && (character == GameData.player or self == GameData.player)

func attack(character, isFirstCollision, base_damage = 0):
	if shouldAttack(character):
		var damage = calculate_damage(character, base_damage)
		
		if damageMultiplierInEffect():
			damage = damageAfterMultiplier(damage)
			reduceDamageMultiplier()
		
		removeInvisibility()
		
		damage = round(damage * 2) / 2

		if self == GameData.player:
			emit_signal("playerAttack", character, damage);
		else:
			emit_signal("attack", self, damage);
		
		#Audio.playHit()
		character.takeDamage(damage)

func takeDamage(damage):
	if damageable:
		stats.health.value -= damage
		damageSinceTemporaryHealthAdded += damage
		
		if self == GameData.player:
			emit_signal("statsChanged", "health", "Down", -damage)

		if stats.health.value <= 0:
			handleCharacterDeath()
		
		createHitmarker(damage)
	else:
		if self == GameData.player:
			GameData.total_blocked_damage += damage
		
		createHitmarker(0, true)

var death_timer
func handleCharacterDeath():
	playDeathAudio()
	GameData.characters.erase(self)
	
	setAnimationOnAllBodyParts("death", true)
	setPlayingOnAllBodyParts(true, true)
	removeStunned()
	
	death_timer = Timer.new()
	death_timer.set_wait_time(1)
	death_timer.connect("timeout",self,"deathAnimationsComplete") 
	death_timer.set_one_shot(true)
	add_child(death_timer)
	death_timer.start()

func revive():
	stats.health.value = stats.health.maximum
	GameData.characters.append(self)
	
	setAnimationOnAllBodyParts("stand_down", true)
	setPlayingOnAllBodyParts(true, true)
	
	death_timer.stop()
	show()

func deathAnimationsComplete():
	hide()
	
	if(self != GameData.player):
		queue_free()

func playDeathAudio():
	if(self == GameData.player):
		#Audio.playSoundEffect("Player_Death", true)
		pass
	else:
		#Audio.playSoundEffect("Enemy_Death", true)
		pass

var hitmarkers = {}

func removeHitmarker(n):
	hitmarkers.erase(n)

func createHitmarker(damage, blocked = false):
	var newNode = Hitmarker.instance()
	newNode.set_scale(Vector2(1,1) / (7*self.get_scale()))
	# Find the lowest available hitsplat spot.
	var index = 0

	while hitmarkers.has(index):
		index += 1
	
	newNode.setN(index)
	newNode.setAmount(damage)
	hitmarkers[index] = newNode
	newNode.connect("death", self, "removeHitmarker")
	self.add_child(newNode)

	if blocked:
		newNode.setBlockedHitmarker()

func targetWalkable(pos):
	return GameData.walkable(pos.x, pos.y)

func alive():
	return stats.health.value > 0

func setWalkAnimation(direction):
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("walk_up")
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("walk_down")
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("walk_left")
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("walk_right")

func setStandAnimation(direction):
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("stand_up")
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("stand_down")
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("stand_left")
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("stand_right")

func setAnimationOnAllBodyParts(animationName, setEvenIfDead = false):
	if alive() or setEvenIfDead:
		for child in self.get_node(bodyPartsNodeName).get_children():
			child.set_animation(animationName)

func setFlip_hOnAllBodyParts(state):
	for child in self.get_node(bodyPartsNodeName).get_children():
		child.set_flip_h( state )

func setPlayingOnAllBodyParts(playingValue, setEvenIfDead = false):
	if alive() or setEvenIfDead:
		for child in self.get_node(bodyPartsNodeName).get_children():
			child.playing = playingValue

func _on_BossDoor_bossDoorOpened():
	resetToStartPosition()

func damageAfterMultiplier(damage):
	return round(damage * 2 * damageMultiplier) / 2

func reduceDamageMultiplier():
	multiplierRemainingAttacks -= 1
	
	if multiplierRemainingAttacks <= 0:
		removeDamageModfier()

func removeDamageModfier():
	multiplierRemainingAttacks = 0

func applyDamageModifier(numberOfAttacks):
	if (numberOfAttacks <= 0):
		return
	
	if multiplierRemainingAttacks < 0:
		multiplierRemainingAttacks = 0
	
	multiplierRemainingAttacks += numberOfAttacks

func damageMultiplierInEffect():
	return multiplierRemainingAttacks > 0

func removeInvisibility():
	invisible = false
	self.set_modulate(Color(1, 1, 1, 1))
	invisibilityTurnsRemaining = -1

func applyInvisibility(turnsAmount):
	if (turnsAmount <= 0):
		return
	
	invisible = true
	self.set_modulate(Color(1, 1, 1, 0.1))
	
	if invisibilityTurnsRemaining < 0:
		invisibilityTurnsRemaining = 0
	
	invisibilityTurnsRemaining += turnsAmount

func increaseMaxHealth(amount):
	if (amount <= 0):
		return
	
	self.stats.health.maximum += amount

func decreaseMaxHealth(amount):
	if (amount <= 0):
		return
	
	self.stats.health.maximum -= amount
	
	if self.stats.health.value > self.stats.health.maximum:
		self.stats.health.value = self.stats.health.maximum

func increaseMaxMana(amount):
	if (amount <= 0):
		return
	
	self.stats.mana.maximum += amount

func decreaseMaxMana(amount):
	self.stats.mana.maximum -= amount
	
	if self.stats.mana.value > self.stats.mana.maximum:
		self.stats.mana.value = self.stats.mana.maximum

func applyTemporaryHealth(turnAmount):
	if (turnAmount <= 0):
		return
	
	if temporaryMaxHeathTurnsRemaining <= 0:
		increaseMaxHealth(temporaryMaxHeathAmount)
		increaseHealth(temporaryMaxHeathAmount)
		healthAfterTemporaryIncreaseAdded = self.stats.health.value
		temporaryMaxHeathTurnsRemaining = 0
	else:
		increaseHealth(min(damageSinceTemporaryHealthAdded, temporaryMaxHeathAmount))
	
	damageSinceTemporaryHealthAdded = 0
	temporaryMaxHeathTurnsRemaining += turnAmount

func removeTemporaryMaxHealth():
	decreaseHealth(max(temporaryMaxHeathAmount - damageSinceTemporaryHealthAdded, 0))
	decreaseMaxHealth(temporaryMaxHeathAmount)
	temporaryMaxHeathTurnsRemaining -= 1

func applyTemporaryStrength(turnAmount):
	if (turnAmount <= 0):
		return
	
	if temporaryStrengthTurnsRemaining <= 0:
		self.stats.strength.value += temporaryStrengthAmount
		self.stats.strength.maximum += temporaryStrengthAmount
		temporaryStrengthTurnsRemaining = 0
	
	temporaryStrengthTurnsRemaining += turnAmount

func removeTemporaryStrength():
	self.stats.strength.value -= temporaryStrengthAmount
	self.stats.strength.maximum -= temporaryStrengthAmount
	temporaryStrengthTurnsRemaining = -1

func applyTemporaryDefence(turnAmount):
	if (turnAmount <= 0):
		return
	
	if temporaryDefenceTurnsRemaining <= 0:
		self.stats.defence.value += temporaryDefenceAmount
		self.stats.defence.maximum += temporaryDefenceAmount
		temporaryDefenceTurnsRemaining = 0
	
	temporaryDefenceTurnsRemaining += turnAmount

func removeTemporaryDefence():
	self.stats.defence.value -= temporaryDefenceAmount
	self.stats.defence.maximum -= temporaryDefenceAmount
	temporaryDefenceTurnsRemaining = -1

func addStun(turnAmount):
	if (turnAmount <= 0):
		return
	
	if stunnedDuration < 0:
		stunnedDuration = 0
	
	stunnedDuration += turnAmount

func removeStunned():
	stunnedDuration = -1
