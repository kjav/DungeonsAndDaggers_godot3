extends "Character.gd"

signal statsChanged(change, value)
signal playerHealed(changeValue)
signal weaponChanged(slot, weapon)
signal itemPickedUp(item)
signal playerMove(pos)
signal turnTimeChange(time_elapsed)
signal playerAttack(character, amount)

const LightBlip = preload("res://Effects/LightBlip.tscn")
var time_elapsed = 0
var attack
var primaryWeapon = Constants.WeaponClasses.BasicSword.new()
var secondaryWeapon = Constants.WeaponClasses.BasicShield.new()
var swipe_funcref
var character_name = 'Player'
var charactersAwaitingMove = false
var animationPlayer
var skeletonScale
var polygonsScale
var currentWeaponNode
var backHandBone
var offHandWeaponNode
var forwardHandBone
var readyToTeleportOnTileSelect
var currentlyUnsureWhyThisIsSignificant
var currentWeaponSlot

func _ready():
	#this is temporary to aid with testing
	increaseMaxHealth(4)
	heal(9)
	increaseMaxMana(9)
	increaseMana(9)
	
	set_process(true)
	swipe_funcref = funcref(self, "swiped")
	EventListener.listen("SwipeCommand", swipe_funcref)
	stats.health.value = stats.health.maximum
	GameData.player = self
	GameData.characters.append(self)
	self.get_node(bodyPartsNodeName).get_node("Body").frames = load("res://assets/SpriteFrames/" + GameData.chosen_player + ".tres")
	animationPlayer = get_node("AnimationPlayer")
	skeletonScale = get_node("Skeleton2D").scale
	polygonsScale = get_node("Polygons").scale
	forwardHandBone = get_node("Skeleton2D/Body/Chest/Left Arm/Left Wrist/Left Hand")
	currentWeaponNode = forwardHandBone.get_node("CurrentWeapon")
	backHandBone = get_node("Skeleton2D/Body/Chest/Right Arm/Right Wrist/Right Hand")
	offHandWeaponNode = backHandBone.get_node("OffHandWeapon")
	
	setSecondaryWeapon(secondaryWeapon)
	setPrimaryWeapon(primaryWeapon)
	setCurrentWeaponSlot(Enums.WEAPONSLOT.PRIMARY)
	faceDirection(Enums.DIRECTION.RIGHT)
	currentlyUnsureWhyThisIsSignificant = Vector2(540, 960)

func getPrimaryHandPosition():
	return forwardHandBone.global_position

func _exit_tree():
	EventListener.ignore("SwipeCommand", swipe_funcref)
	GameData.reset()

func setCurrentWeaponSlot(slot):
	currentWeaponSlot = slot

	var chosenWeapon = getCurrentWeapon()
	var offHandWeapon = getOffHandWeapon()

	GameData.hud.SetCurrentWeapon(slot)

	if chosenWeapon != null:
		currentWeaponNode.set_texture(chosenWeapon.texture)
		currentWeaponNode.set_offset(chosenWeapon.offset)
		currentWeaponNode.set_rotation(chosenWeapon.rotationInHand)
		offHandWeaponNode.set_texture(offHandWeapon.texture)
		offHandWeaponNode.set_offset(offHandWeapon.offset)
		offHandWeaponNode.set_rotation(offHandWeapon.rotationInOffHand)
		additionalRelativeAttackPositions = chosenWeapon.relativeAttackPositions
		onlyAttacksFirstEnemy = chosenWeapon.onlyAttacksFirstEnemy
		attackPositionBlockable = chosenWeapon.attackPositionBlockable

func getCurrentWeapon():
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		return primaryWeapon
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		return secondaryWeapon

func getOffHandWeapon():
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		return secondaryWeapon
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		return primaryWeapon

func swapWeapons():
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		GameData.hud.SetCurrentWeapon(Enums.WEAPONSLOT.SECONDARY)
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		GameData.hud.SetCurrentWeapon(Enums.WEAPONSLOT.PRIMARY)

func setCurrentWeapon(weapon):
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		setPrimaryWeapon(weapon)
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		setSecondaryWeapon(weapon)
	
func setPrimaryWeapon(weapon):
	primaryWeapon = weapon
	emit_signal("weaponChanged", Enums.WEAPONSLOT.PRIMARY, primaryWeapon)
	
	setCurrentWeaponSlot(currentWeaponSlot)

func setSecondaryWeapon(weapon):
	secondaryWeapon = weapon
	emit_signal("weaponChanged", Enums.WEAPONSLOT.SECONDARY, secondaryWeapon)
	
	setCurrentWeaponSlot(currentWeaponSlot)

func dropWeapon():
	var currentWeapon = getCurrentWeapon()
	
	currentWeapon.place(get_position())
	currentWeapon = null

func faceDirection(direction):
	if alive():
		match direction:
			Enums.DIRECTION.UP:
				animationPlayer.current_animation = "stand"
			Enums.DIRECTION.DOWN:
				animationPlayer.current_animation = "stand"
			Enums.DIRECTION.LEFT:
				animationPlayer.current_animation = "stand"
				get_node("Skeleton2D").scale = Vector2(skeletonScale.x * -1, skeletonScale.y)
				get_node("Polygons").scale = Vector2(polygonsScale.x * -1, polygonsScale.y)
			Enums.DIRECTION.RIGHT:
				animationPlayer.current_animation = "stand"
				get_node("Skeleton2D").scale = skeletonScale
				get_node("Polygons").scale = polygonsScale

func setWalkAnimation(direction):
	match direction:
		Enums.DIRECTION.UP:
			animationPlayer.current_animation = "walk"
		Enums.DIRECTION.DOWN:
			animationPlayer.current_animation = "walk"
		Enums.DIRECTION.LEFT:
			animationPlayer.current_animation = "walk"
			get_node("Skeleton2D").scale = Vector2(skeletonScale.x * -1, skeletonScale.y)
			get_node("Polygons").scale = Vector2(polygonsScale.x * -1, polygonsScale.y)
		Enums.DIRECTION.RIGHT:
			animationPlayer.current_animation = "walk"
			get_node("Skeleton2D").scale = skeletonScale
			get_node("Polygons").scale = polygonsScale

func setStandAnimation(direction):
	match direction:
		Enums.DIRECTION.UP:
			animationPlayer.current_animation = "stand"
		Enums.DIRECTION.DOWN:
			animationPlayer.current_animation = "stand"
		Enums.DIRECTION.LEFT:
			animationPlayer.current_animation = "stand"
			get_node("Skeleton2D").scale = Vector2(skeletonScale.x * -1, skeletonScale.y)
			get_node("Polygons").scale = Vector2(polygonsScale.x * -1, polygonsScale.y)
		Enums.DIRECTION.RIGHT:
			animationPlayer.current_animation = "stand"
			get_node("Skeleton2D").scale = skeletonScale
			get_node("Polygons").scale = polygonsScale

func swiped(direction):
	if not (moving or charactersAwaitingMove or GameData.charactersMoving()):
		.turn()
		time_elapsed = 0
		#Audio.playWalk()
		moveDirection(direction)
		emit_signal("playerMove", self.target_pos / 128)
		emit_signal("turnTimeChange", time_elapsed)
		
		charactersAwaitingMove = true
		
		var timer = Timer.new()
		timer.set_wait_time(0.4)
		timer.connect("timeout",self,"MoveCharacters") 
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()

func MoveCharacters():
	charactersAwaitingMove = false
	
	for i in range(GameData.characters.size()):
		if i < GameData.characters.size():
			GameData.characters[i].turn()
			# Ensure the character hasn't died during the turn and been removed
			if len(GameData.characters) > i:
				GameData.characters[i].setTurnAnimations()

func attack(character, base_damage = 0):
	if alive():
		var currentWeapon = getCurrentWeapon()
		
		emit_signal("playerAttack", character, currentWeapon.damage)
		currentWeapon.onAttack(character)
		.attack(character, currentWeapon.damage)

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
			elif movement_direction == Enums.DIRECTION.RIGHT:
				set_position(original_pos + Vector2(length, 0))
			elif movement_direction == Enums.DIRECTION.UP:
				set_position(original_pos + Vector2(0, -length))
			elif movement_direction == Enums.DIRECTION.DOWN:
				set_position(original_pos + Vector2(0, length))

			setStandAnimation(movement_direction)
			moving = false
			time_elapsed = 0
	else:
		time_elapsed += delta
		emit_signal("turnTimeChange", time_elapsed)
		if time_elapsed >= 1:
			# forefit turn
			time_elapsed = 0
			moveDirection(Enums.DIRECTION.NONE)
			MoveCharacters()

func takeDamage(damage):
	var damageableStore = damageable
	primaryWeapon.onPlayerDamaged()
	secondaryWeapon.onPlayerDamaged()
	
	.takeDamage(damage)
	damageable = damageableStore

func handleCharacterDeath():
	currentWeaponNode.hide()
	offHandWeaponNode.hide()
	get_node("Polygons").hide()
	.handleCharacterDeath()

func pickUpTopItem():
	pickUp(GameData.itemAtPos(self.get_position()/GameData.TileSize))

func pickUp(item):
	if (item != null):
		item.pickup()
		emit_signal("itemPickedUp", item)

func heal(amount, evenIfDead = false):
	emit_signal("playerHealed", min(amount, self.stats.health.maximum - self.stats.health.value))
	.heal(amount, evenIfDead)

func increaseHealth(amount, evenIfDead = false):
	.increaseHealth(amount, evenIfDead)
	emit_signal("statsChanged", "health", "Up", amount)

func increaseMana(amount):
	.increaseMana(amount)
	emit_signal("statsChanged", "mana", "Up", amount)

func consume_stat(stat, amount):
	#remove when mana is readded
	if stat == "mana":
		return true
	
	if stats[stat].value >= amount:
		stats[stat].value -= amount
		emit_signal("statsChanged", stat, "Down", amount)
		return true
	return false

func increaseMaxHealth(amount):
	.increaseMaxHealth(amount)
	emit_signal("statsChanged", "maxhealth", "Up", amount)

func decreaseMaxHealth(amount):
	.decreaseMaxHealth(amount)
	emit_signal("statsChanged", "maxhealth", "Down", amount)

func increaseMaxMana(amount):
	.increaseMaxMana(amount)
	emit_signal("statsChanged", "maxmana", "Up", amount)

func decreaseMaxMana(amount):
	.decreaseMaxMana(amount)
	emit_signal("statsChanged", "maxmana", "Down", amount)

func gameClickableRegionClicked(event):
	if not readyToTeleportOnTileSelect:
		return
	
	if moving or charactersAwaitingMove or GameData.charactersMoving():
		GameData.hud.addEventMessage("Can't use that while turn is completing.")
		return

	var tilePositionRelativeToCamera = (event.position + (get_node("Camera2D").get_camera_screen_center()) - currentlyUnsureWhyThisIsSignificant) / GameData.TileSize
	var tilePositionRelativeToCameraRounded = Vector2(floor(tilePositionRelativeToCamera.x), floor(tilePositionRelativeToCamera.y))
	var player_pos = (GameData.player.turn_end_pos) / GameData.TileSize
	var distance = GameData.tilemap.findPathDistance(tilePositionRelativeToCameraRounded, player_pos)
	
	if (distance > 0):
		if (distance < 20):
			if (GameData.player.handleForcedMoveTo(tilePositionRelativeToCameraRounded)):
				get_node("LightBlip").play("finish")
				get_node("LightBlip").hideOnComplete()
				
				readyToTeleportOnTileSelect = false
				GameData.hud.SetVisibilityOfTeleportWarning(false)
				GameData.hud.addEventMessage("Player Teleported!")
			else:
				GameData.hud.addEventMessage("Can't teleport there!")
		else:
			GameData.hud.addEventMessage("Can't teleport, path too far")
	else:
		GameData.hud.addEventMessage("Can't teleport there!")