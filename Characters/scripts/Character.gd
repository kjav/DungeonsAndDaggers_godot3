extends Node2D

signal attack(character, amount)

var moving = false
var movement_direction = Enums.DIRECTION.NONE
var original_pos = get_position()
var target_pos = get_position()
var damageable = true
var initial_pos
var isPartOfBossRoom

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
		"value": 5,
		"maximum": 5
	},
	"defence": {
		"value": 5,
		"maximum": 5
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

func roundVector2(pos):
	return Vector2(round(pos.x), round(pos.y))

func _ready():
	original_pos = get_position()
	target_pos = get_position()
	initial_pos = get_position()
	
	resetStats()

func resetStats():
	#this is because godot 3.0 doesn't have a deep duplicate.
	stats.health = initialStats.health.duplicate()
	stats.mana = initialStats.mana.duplicate()
	stats.strength = initialStats.strength.duplicate()
	stats.defence = initialStats.defence.duplicate()
	
func turn():
	pass

func consume_stat(stat, amount):
	if stats[stat].value >= amount:
		stats[stat].value -= amount
		return true
	return false

func moveDirection(direction):
	if (not moving) and alive():
		original_pos = get_position()
		movement_direction = Enums.DIRECTION.NONE
		
		#think this is why enemies never use stand animation, remove this and add case to face direction and it might work
		if direction != Enums.DIRECTION.NONE:
			movement_direction = handleMove(direction)
		
		setTarget(movement_direction)
		moving = true
		
		return true

func handleMove(direction):
	faceDirection(direction)
	
	var pos = setTarget(direction)
	var attacking = handleEnemyCollisions(absoluteAttackPositions(pos, direction))
	
	if not attacking:
		var walkableEnvironment = handleEnvironmentCollisions(pos)
		if walkableEnvironment:
			if targetWalkable(pos):
				setWalkAnimation(direction)
				
				return direction
			else:
				return Enums.DIRECTION.NONE
	
	return Enums.DIRECTION.NONE

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
	pos = getNextTargetPos(pos, direction)
	target_pos = pos
	target_pos.x *= GameData.TileSize
	target_pos.y *= GameData.TileSize
	
	return pos

func getNextTargetPos(pos, direction):
	match direction:
		Enums.DIRECTION.UP:
			pos.y -= 1
		Enums.DIRECTION.DOWN:
			pos.y += 1
		Enums.DIRECTION.LEFT:
			pos.x -= 1
		Enums.DIRECTION.RIGHT:
			pos.x += 1
	
	return pos

func absoluteAttackPositions(targetPos, direction):
	var additional = additionalAbosoluteAttackPositions(targetPos, direction)
	if additional.size() > 0:
		print("SAD")
		print(additional[0].x)
		print(additional[0].y)
		print(targetPos.x)
		print(targetPos.y)
		print("asda")
	return([targetPos] + additional)

func additionalAbosoluteAttackPositions(targetPos, direction):
	if (additionalRelativeAttackPositions.size() > 0):
		return convertRelativePositionToAbsolute(targetPos, additionalRelativeAttackPositions, direction)
	
	return []
	
func convertRelativePositionToAbsolute(currentPosition, relativePositions, direction):
	var phi
	
	match direction:
		Enums.DIRECTION.UP:
			phi = 0
		Enums.DIRECTION.DOWN:
			phi = PI
		Enums.DIRECTION.LEFT:
			phi = (3 *  PI) / 2
		Enums.DIRECTION.RIGHT:
			phi = PI /2
		Enums.DIRECTION.NONE:
			return []
	
	var AbsolutePositions = []

	for relativePosition in relativePositions:
		var rotated = relativePosition.rotated(phi)
		AbsolutePositions = AbsolutePositions + [roundVector2(rotated) + currentPosition]
	
	return AbsolutePositions

func handleEnemyCollisions(posArray):
	var collisions = []
	var collided = false
	
	for pos in posArray:
		if not targetWalkable(pos) and attackPositionBlockable:
			break;
		
		collisions += GameData.charactersAtPos(pos)

	for collision in collisions:
		if not (collision == self):
			attack(collision)
			collided = true

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
		
	return walkable

func sample_normal_distribution(mean, sd):
	# Use the Box-Muller transform to sample from the given normal distribution.
	# https://en.wikipedia.org/wiki/Box-Muller_transform
	return sqrt(-2 * log(randf())) * cos(2 * PI * randf())

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
	if difference > 0:
		# When there is a difference in stats, use the infinite sum 1/(5 * 1.1^x) to
		# calculate an adjusted mean, between 0 and 2. When the difference in stats
		# is 1, the mean will be about 0.18. When the difference is 2, the mean will
		# be 0.165. Etc.
		mean = difference_sign / (5 * pow(1.1, difference))

	# Use a fixed standard deviation. The value 1.5 gives a 10% chance of getting
	# a modifier of 0 or 2 for equal stats (i.e. a difference of 0).
	var sd = 1.5
	
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

func attack(character, base_damage):
	if alive():
		if (character == GameData.player) or (self == GameData.player):
			var damage = calculate_damage(character, base_damage)
			emit_signal("attack", self, damage);
			
			if (character.damageable):
				#Audio.playHit()
				character.takeDamage(damage)

func takeDamage(damage):
	stats.health.value -= damage
	if stats.health.value <= 0:
		handleCharacterDeath()
	createHitmarker(damage)

func handleCharacterDeath():
	playDeathAudio()
	GameData.characters.erase(self)
	print("Death: ")
	setAnimationOnAllBodyParts("death")
	setPlayingOnAllBodyParts(true)

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

func createHitmarker(damage):
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

func targetWalkable(pos):
	return GameData.walkable(pos.x, pos.y)

func alive():
	return stats.health.value > 0

func setWalkAnimation(direction):
	print("Walking ", direction)
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
	print("Standing ", direction)
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("stand_up")
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("stand_down")
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("stand_left")
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("stand_right")

func setAnimationOnAllBodyParts(animationName):
	for child in self.get_node(bodyPartsNodeName).get_children():
		child.set_animation(animationName)

func setPlayingOnAllBodyParts(playingValue):
	for child in self.get_node(bodyPartsNodeName).get_children():
		child.playing = playingValue

func _on_BossDoor_bossDoorOpened():
	resetToStartPosition()