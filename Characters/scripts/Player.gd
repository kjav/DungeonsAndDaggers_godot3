extends "Character.gd"

signal statsChanged(change, value)
signal playerHealed(changeValue)
signal weaponChanged(slot, weapon)
signal itemPickedUp(item)
signal playerMove(pos)
signal turnTimeChange(time_elapsed)
signal playerAttack(character, amount)
signal turnEnd()

const LightBlip = preload("res://Effects/LightBlip.tscn")
const Text = preload("res://Effects/Text.tscn")
var time_elapsed = 0
var attack
var primaryWeapon = Constants.WeaponClasses.CommonSword.new()
var secondaryWeapon = Constants.WeaponClasses.Unarmed.new()
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
var half_screen_size
var currentWeaponSlot
var hasMoved
var lastEvent
var applePickedUp = false

func _init():
	initialStats.health = {
		"value": 4,
		"maximum": 4
	}
	
	initialStats.strength = {
		"value": 4,
		"maximum": 4
	}
	
	initialStats.defence = {
		"value": 4,
		"maximum": 4
	}

func _ready():
	set_process(true)
	swipe_funcref = funcref(self, "swiped")
	EventListener.listen("SwipeCommand", swipe_funcref)
	stats.health.value = stats.health.maximum
	GameData.player = self
	GameData.characters.append(self)
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
	half_screen_size = Vector2(540, 960)
	
	if GameData.chosen_map == "Tutorial":
		stats.health.value -= 1
	
	addTutorialTextIfTutorial("Swipe to\nmove", Vector2(5, 9.3))
	addTutorialTextIfTutorial("These are\ncrucial, they\noffer random\nupgrades", Vector2(7.1, -2.9))
  
	if GameData.saved_player:
		print("Here!")
		setPrimaryWeapon(GameData.saved_player.primaryWeapon)
		setSecondaryWeapon(GameData.saved_player.secondaryWeapon)
		stats = GameData.saved_player.stats

func addTutorialTextIfTutorial(text, pos):
	if GameData.chosen_map == "Tutorial":
		var textNode = Text.instance()
		textNode.set_position(pos * GameData.TileSize)
		textNode.set_text(text)
		GameData.hud.get_node("TutorialTextPrompts").add_child(textNode)

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
		setCurrentWeaponSlot(Enums.WEAPONSLOT.SECONDARY)
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		setCurrentWeaponSlot(Enums.WEAPONSLOT.PRIMARY)

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
	
	if currentWeapon.equiptable:
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

func forceTurnEnd(direction = Enums.DIRECTION.NONE):
	.turn()
	time_elapsed = 0
	#Audio.playWalk()
	moveDirection(direction)
	emit_signal("playerMove", self.target_pos / 128)
	emit_signal("turnTimeChange", time_elapsed)
	
	charactersAwaitingMove = true
	
	if direction == Enums.DIRECTION.NONE:
		MoveCharacters()
	else:
		var timer = Timer.new()
		timer.set_wait_time(GameData.turnTime)
		timer.connect("timeout",self,"MoveCharacters") 
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()
	
	checkForTutorialPrompts()
	
	hasMoved = true

func checkForTutorialPrompts():
	if not hasMoved:
		addTutorialTextIfTutorial("Move into\nenemies\nto attack", Vector2(6.4, 7.2))
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(768, 768) && GameData.current_level == 1 && !applePickedUp:
		GameData.hud.get_node("TutorialTextPrompts").get_child(3).set_text("To Pickup\nClick The\nFloating Menu\nThis Uses\nA Turn")
		GameData.hud.get_node("TutorialTextPrompts").get_child(3).set_position(Vector2(7, 6.1) * GameData.TileSize)
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(640, -512) && GameData.current_level == 1:
		addTutorialTextIfTutorial("Click The\nFloating Menu\nTo Go\nTo The\nNext Level", Vector2(4.6, -5.5))
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(512, 1152) && GameData.current_level == 2:
			GameData.player.addTutorialTextIfTutorial("Weapons Have\nDifferent Levels\nBlue's Best\nThen Green\nLast Is Grey", Vector2(1.8, 6))
			GameData.player.addTutorialTextIfTutorial("Good luck\nand have fun", Vector2(4.7, 5.3))

func _input(ev):
	if ev is InputEventKey and not ev.echo:
		if ev.scancode == KEY_LEFT:
			swiped(Enums.DIRECTION.LEFT)
		elif ev.scancode == KEY_RIGHT:
			swiped(Enums.DIRECTION.RIGHT)
		elif ev.scancode == KEY_UP:
			swiped(Enums.DIRECTION.UP)
		elif ev.scancode == KEY_DOWN:
			swiped(Enums.DIRECTION.DOWN)

func swiped(direction):
	if not (moving or charactersAwaitingMove or GameData.charactersMoving()):
		forceTurnEnd(direction)

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
		var offhandWeapon = getOffHandWeapon()
		
		if currentWeapon.ammo != 0:
			currentWeapon.onAttack(character)

			if currentWeapon.doesDamage:
				.attack(character, currentWeapon.damage)
			
			if character.character_name == "Training Dummy" && not character.alive() && GameData.current_level == 1:
				addTutorialTextIfTutorial("Move on\nitems to\npick up", Vector2(7, 6.2))
				addTutorialTextIfTutorial("Careful!\nenemies move\ninto you\nto attack", Vector2(5.2, 3.5))
			
			GameData.hud.get_node("HudCanvasLayer/WeaponSlots").updateAmmo(currentWeaponSlot, currentWeapon.ammo)
			
			if currentWeapon.ammo == 0:
				removeCurrentWeapon()
		else:
			removeCurrentWeapon()
		
		if offhandWeapon is Constants.WeaponClasses.CommonDagger && currentWeapon.isMelee && target_pos == character.target_pos:
			.attack(character, offhandWeapon.damage)

func removeCurrentWeapon():
	setCurrentWeapon(Constants.WeaponClasses.Unarmed.new())
	swapWeapons()

func _process(delta):
	if moving:
		var length = 128
		time_elapsed = time_elapsed + delta
		if movement_direction == Enums.DIRECTION.LEFT:
			self.set_position(get_position() + Vector2(-length * (delta / GameData.turnTime), 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			self.set_position(get_position() + Vector2(length * (delta / GameData.turnTime), 0))
		if movement_direction == Enums.DIRECTION.UP:
			self.set_position(get_position() + Vector2(0, -length * (delta / GameData.turnTime)))
		elif movement_direction == Enums.DIRECTION.DOWN:
			self.set_position(get_position() + Vector2(0, length * (delta / GameData.turnTime)))
		if time_elapsed >= GameData.turnTime:
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
			emit_signal("turnEnd")
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
	
	if GameData.chosen_map == "Tutorial":
		damage = min(damage, stats.health.value - 0.5)
	
	.takeDamage(damage)
	damageable = damageableStore

func handleCharacterDeath():
	GameData.delete_saved_game()
	print("Deleted save game")
	currentWeaponNode.hide()
	offHandWeaponNode.hide()
	get_node("Polygons").hide()
	.handleCharacterDeath()

func pickUpTopItem():
	pickUp(GameData.itemAtPos(self.get_position()/GameData.TileSize))
	
func pickUpWeapon(weapon):
	if not getOffHandWeapon().equiptable:
		swapWeapons()
	
	dropWeapon()
	setCurrentWeapon(weapon)

func pickUp(item):
	if (item != null):
		item.pickup()
		emit_signal("itemPickedUp", item)
		
		if GameData.chosen_map == "Tutorial" && item.item_name == "Apple" && GameData.current_level == 1:
			applePickedUp = true
			GameData.hud.get_node("TutorialTextPrompts").get_child(3).set_text("Click food\nicon at\npage bottom\nto eat")
			GameData.hud.get_node("TutorialTextPrompts").get_child(3).set_position(Vector2(7, 6.1) * GameData.TileSize)

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

func gameClickableRegionClicked(event = null):
	if event == null:
		event = lastEvent
	else:
		lastEvent = event
	
	if not readyToTeleportOnTileSelect:
		return
	
	if moving or charactersAwaitingMove or GameData.charactersMoving():
		self.connect("turnEnd",self,"gameClickableRegionClicked", [], CONNECT_ONESHOT)
		return

	var tilePositionRelativeToCamera = (event.position + (get_node("Camera2D").get_camera_screen_center()) - half_screen_size) / GameData.TileSize
	var tilePositionRelativeToCameraRounded = Vector2(floor(tilePositionRelativeToCamera.x), floor(tilePositionRelativeToCamera.y))
	var player_pos = (GameData.player.turn_end_pos) / GameData.TileSize
	var distance = GameData.tilemap.findPathDistance(tilePositionRelativeToCameraRounded, player_pos)
	
	if (distance > 0):
		if (GameData.player.handleForcedMoveTo(tilePositionRelativeToCameraRounded)):
			get_node("LightBlip").play("finish")
			get_node("LightBlip").hideOnComplete()
			
			readyToTeleportOnTileSelect = false
			GameData.hud.SetVisibilityOfTeleportWarning(false)
			GameData.hud.addEventMessage("Player Teleported!")
			emit_signal("playerMove", tilePositionRelativeToCameraRounded)
		else:
			GameData.hud.addEventMessage("Can't teleport there!")
	else:
		GameData.hud.addEventMessage("Can't teleport there!")