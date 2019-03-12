extends AnimatedSprite

signal attack(character, amount)

var moving = false
var movement_direction
var original_pos = get_position()
var target_pos = get_position()
var damageable = true

var stats = {
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
var additionalRelativeAttackPositions = []
var attackPositionBlockable = true
var onlyAttacksFirstEnemy = true

const Hitmarker = preload("res://Characters/Hitmarker.tscn")


func roundVector2(pos):
	return Vector2(round(pos.x), round(pos.y))

func _ready():
	original_pos = get_position()
	target_pos = get_position()

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
	var additional = generateAdditionalAbosoluteAttackPositions(direction)
	var attacking = handleEnemyCollisions([pos] + additional)
	
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
		if direction == Enums.DIRECTION.UP:
			set_animation("stand_up")
		elif direction == Enums.DIRECTION.DOWN:
			set_animation("stand_down")
		elif direction == Enums.DIRECTION.LEFT:
			set_animation("stand_left")
		elif direction == Enums.DIRECTION.RIGHT:
			set_animation("stand_right")

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
	if direction == Enums.DIRECTION.UP:
		pos.y -= 1
	elif direction == Enums.DIRECTION.DOWN:
		pos.y += 1
	elif direction == Enums.DIRECTION.LEFT:
		pos.x -= 1
	elif direction == Enums.DIRECTION.RIGHT:
		pos.x += 1
	
	return pos

func generateAdditionalAbosoluteAttackPositions(direction):
	var phi
	
	if direction == Enums.DIRECTION.UP:
		phi = 0
	elif direction == Enums.DIRECTION.DOWN:
		phi = PI
	elif direction == Enums.DIRECTION.LEFT:
		phi = PI /2
	elif direction == Enums.DIRECTION.RIGHT:
		phi = (3 *  PI) / 2
	
	var AbsolutePositions = []

	for relativePosition in additionalRelativeAttackPositions:
		var rotated = relativePosition.rotated(phi)
		var targetPosDivided = target_pos / GameData.TileSize
		AbsolutePositions = AbsolutePositions + [roundVector2(rotated) + targetPosDivided]
	
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
	
	for i in range(collisions.size()):
		if !collisions[i].walkable:
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
	set_animation("death")

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
	if direction == Enums.DIRECTION.UP:
		self.set_animation("walk_up")
	elif direction == Enums.DIRECTION.DOWN:
		self.set_animation("walk_down")
	elif direction == Enums.DIRECTION.LEFT:
		self.set_animation("walk_left")
	elif direction == Enums.DIRECTION.RIGHT:
		self.set_animation("walk_right")

