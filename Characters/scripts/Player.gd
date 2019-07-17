extends "Character.gd"

signal statsChanged(change, value)
signal weaponChanged(slot, weapon)
signal itemPickedUp(item)
signal playerMove(pos)
signal playerAttack(character, amount)

var time_elapsed = 0
var attack
var primaryWeapon = Constants.WeaponClasses.BasicSword.new()
var secondaryWeapon = Constants.WeaponClasses.BasicShield.new()
var swipe_funcref
var character_name = 'Player'

func _ready():
	set_process(true)
	swipe_funcref = funcref(self, "swiped")
	EventListener.listen("SwipeCommand", swipe_funcref)
	stats.health.value = stats.health.maximum
	GameData.player = self
	GameData.characters.append(self)
	self.get_node(bodyPartsNodeName).get_node("Body").frames = load("res://assets/SpriteFrames/" + GameData.chosen_player + ".tres")

func _exit_tree():
	EventListener.ignore("SwipeCommand", swipe_funcref)
	GameData.reset()

func swapWeapons():
	var temp = primaryWeapon
	setPrimaryWeapon(secondaryWeapon)
	setSecondaryWeapon(temp)

func setPrimaryWeapon(weapon):
	primaryWeapon = weapon
	emit_signal("weaponChanged", "Primary", primaryWeapon)
	get_node("PrimaryWeapon").set_texture(primaryWeapon.texture)
	additionalRelativeAttackPositions = weapon.relativeAttackPositions
	onlyAttacksFirstEnemy = weapon.onlyAttacksFirstEnemy
	attackPositionBlockable = weapon.attackPositionBlockable

func setSecondaryWeapon(weapon):
	secondaryWeapon = weapon
	emit_signal("weaponChanged", "Secondary", secondaryWeapon)
	get_node("SecondaryWeapon").set_texture(secondaryWeapon.texture)

func dropWeapon():
	primaryWeapon.place(get_position())
	primaryWeapon = null

func swiped(direction):
	if not moving:
		time_elapsed = 0
		#Audio.playWalk()
		moveDirection(direction)
		set_weapon_positions(direction)
		for i in range(GameData.characters.size()):
			if i < GameData.characters.size():
				GameData.characters[i].turn()
		emit_signal("playerMove", self.target_pos / 128)

func attack(character):
	if alive():
		emit_signal("playerAttack", character, primaryWeapon.damage)
		.attack(character, primaryWeapon.damage)

func _process(delta):
	if moving:
		var length = 128
		time_elapsed = time_elapsed + delta
		if movement_direction == Enums.DIRECTION.LEFT:
			self.set_position(get_position() + Vector2(-length * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			self.set_position(get_position() + Vector2(length * (delta / 0.4), 0))
		if movement_direction == Enums.DIRECTION.UP:
			self.set_position(get_position() + Vector2(0, -length * (delta / 0.4)))
		elif movement_direction == Enums.DIRECTION.DOWN:
			self.set_position(get_position() + Vector2(0, length * (delta / 0.4)))
		if time_elapsed >= 0.4:
			if movement_direction == Enums.DIRECTION.LEFT:
				set_position(original_pos + Vector2(-length, 0))
				setAnimationOnAllBodyParts("stand_left")
			elif movement_direction == Enums.DIRECTION.RIGHT:
				set_position(original_pos + Vector2(length, 0))
				setAnimationOnAllBodyParts("stand_right")
			elif movement_direction == Enums.DIRECTION.UP:
				set_position(original_pos + Vector2(0, -length))
				setAnimationOnAllBodyParts("stand_up")
			elif movement_direction == Enums.DIRECTION.DOWN:
				set_position(original_pos + Vector2(0, length))
				setAnimationOnAllBodyParts("stand_down")
			moving = false
			time_elapsed = 0
	else:
		time_elapsed += delta
		if time_elapsed >= 1:
			# forefit turn
			time_elapsed = 0
			moveDirection(Enums.DIRECTION.NONE)
			for i in range(GameData.characters.size()):
				if i < GameData.characters.size():
					GameData.characters[i].turn()

func takeDamage(damage):
	.takeDamage(damage)
	emit_signal("statsChanged", "health", "Down", -damage)

func handleCharacterDeath():
	get_node("PrimaryWeapon").hide()
	get_node("SecondaryWeapon").hide()
	.handleCharacterDeath()

func pickUp():
	var item = GameData.itemAtPos(self.get_position()/GameData.TileSize)
	if (item != null):
		item.pickup()
		emit_signal("itemPickedUp", item)

func heal(amount):
	.heal(amount)
	
	emit_signal("statsChanged", "health", "Up", amount)

func consume_stat(stat, amount):
	if stats[stat].value >= amount:
		stats[stat].value -= amount
		emit_signal("statsChanged", stat, "Down", amount)
		return true
	return false

func increaseMax(amount):
	self.stats.health.maximum += amount
	emit_signal("statsChanged", "maxhealth", "Up", amount)

func set_weapon_positions(dir):
	var weapon = self.get_node("PrimaryWeapon")
	var secondary = self.get_node("SecondaryWeapon")
	if dir == Enums.DIRECTION.DOWN:
		weapon.set_draw_behind_parent(false)
		if weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(false)
		weapon.set_position(primaryWeapon.holdOffset[0])
		secondary.set_draw_behind_parent(false)
		secondary.set_flip_h(false)
		secondary.set_position(secondaryWeapon.holdOffset[0])
	elif dir == Enums.DIRECTION.UP:
		weapon.set_draw_behind_parent(true)
		if !weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(true)
		weapon.set_position(primaryWeapon.holdOffset[1])
		secondary.set_draw_behind_parent(true)
		secondary.set_flip_h(true)
		secondary.set_position(secondaryWeapon.holdOffset[1])
	elif dir == Enums.DIRECTION.LEFT:
		weapon.set_draw_behind_parent(true)
		if weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(false)
		weapon.set_position(primaryWeapon.holdOffset[2])
		secondary.set_draw_behind_parent(false)
		secondary.set_flip_h(false)
		secondary.set_position(secondaryWeapon.holdOffset[2])
	elif dir == Enums.DIRECTION.RIGHT:
		weapon.set_draw_behind_parent(false)
		if !weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(true)
		weapon.set_position(primaryWeapon.holdOffset[3])
		secondary.set_draw_behind_parent(true)
		secondary.set_flip_h(true)
		secondary.set_position(secondaryWeapon.holdOffset[3])

