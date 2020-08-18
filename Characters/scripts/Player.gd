extends "Character.gd"

signal statsChanged(change, value)
signal playerHealed(changeValue)
signal weaponChanged(slot, weapon)
signal itemPickedUp(item)
signal playerMove(pos)
signal turnTimeChange(time_elapsed)
signal playerAttack(character, amount)
signal turnEnd()

var lastdone = OS.get_ticks_msec()

const DirectionArrow = preload("res://VisualEffects/DirectionArrow.tscn")
const LightBlip = preload("res://VisualEffects/LightBlip.tscn")
var time_elapsed = 0
var attack
var primaryWeapon = Constants.WeaponClasses.CommonSword.new()
var secondaryWeapon = Constants.WeaponClasses.Unarmed.new()
var tertiaryWeapon = Constants.WeaponClasses.Unarmed.new()
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
var lastDirection = Enums.DIRECTION.NONE
var spellUsesTurn
var foodUsesTurn
var potionUsesTurn
var canAlwaysHurtReapers
var increasedSpellDamage
var increasedFoodHeal
var extendBriefPotions
var thirdWeaponSlot
var thirdUpgradeSlot
var shieldOnDamageUsedForTurn
var moveStack = []
var appleWalkedInto = false
var offhandWeaponMessageShown = false
var rarityWeaponMessageShown = false
var goodLuckMessageShown = false

func _init():
	initialStats.health = {
		"value": 5,
		"maximum": 5
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
	self.connect("turnTimeChange", self, "performMoveStack")
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
	spellUsesTurn = true
	foodUsesTurn = true
	potionUsesTurn = true
	thirdWeaponSlot = false
	thirdUpgradeSlot = false
	
	setSecondaryWeapon(secondaryWeapon)
	setTertiaryWeapon(tertiaryWeapon)
	setPrimaryWeapon(primaryWeapon)
	setCurrentWeaponSlot(Enums.WEAPONSLOT.PRIMARY)
	faceDirection(Enums.DIRECTION.RIGHT)
	half_screen_size = Vector2(540, 960)
	
	GameData.addTutorialTextIfTutorial("Swipe to\nmove.", Vector2(5, 9.3))
	GameData.addTutorialTextIfTutorial("These offer\nrandom upgrades\nto improve\nyour character.", Vector2(7.1, -2.9))
	
	._ready()
	
	if GameData.saved_player:
		setPrimaryWeapon(GameData.saved_player.primaryWeapon)
		setSecondaryWeapon(GameData.saved_player.secondaryWeapon)
		setTertiaryWeapon(GameData.saved_player.tertiaryWeapon)
		stats = GameData.saved_player.stats
		foodUsesTurn = GameData.saved_player.foodUsesTurn
		spellUsesTurn = GameData.saved_player.spellUsesTurn
		potionUsesTurn = GameData.saved_player.potionUsesTurn
		trapImmune = GameData.saved_player.trapImmune
		canAlwaysHurtReapers = GameData.saved_player.canAlwaysHurtReapers
		increasedSpellDamage = GameData.saved_player.increasedSpellDamage
		increasedFoodHeal = GameData.saved_player.increasedFoodHeal
		extendBriefPotions = GameData.saved_player.extendBriefPotions
		thirdWeaponSlot = GameData.saved_player.thirdWeaponSlot
		thirdUpgradeSlot = GameData.saved_player.thirdUpgradeSlot
	
	if GameData.chosen_map == "Tutorial":
		stats.health.value -= 1

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
		offHandWeaponNode.set_texture(offHandWeapon.offhandTexture)
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
	elif currentWeaponSlot == Enums.WEAPONSLOT.TERTIARY:
		return tertiaryWeapon

func getOffHandWeapon():
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		return secondaryWeapon
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		return primaryWeapon
	elif currentWeaponSlot == Enums.WEAPONSLOT.TERTIARY:
		return secondaryWeapon

func swapWeapons():
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		setCurrentWeaponSlot(Enums.WEAPONSLOT.SECONDARY)
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		setCurrentWeaponSlot(Enums.WEAPONSLOT.PRIMARY)
	elif currentWeaponSlot == Enums.WEAPONSLOT.TERTIARY:
		setCurrentWeaponSlot(Enums.WEAPONSLOT.PRIMARY)

func setCurrentWeapon(weapon):
	if currentWeaponSlot == Enums.WEAPONSLOT.PRIMARY:
		setPrimaryWeapon(weapon)
	elif currentWeaponSlot == Enums.WEAPONSLOT.SECONDARY:
		setSecondaryWeapon(weapon)
	elif currentWeaponSlot == Enums.WEAPONSLOT.TERTIARY:
		setTertiaryWeapon(weapon)
	
func setPrimaryWeapon(weapon):
	primaryWeapon = weapon
	emit_signal("weaponChanged", Enums.WEAPONSLOT.PRIMARY, primaryWeapon)
	
	setCurrentWeaponSlot(currentWeaponSlot)

func setSecondaryWeapon(weapon):
	secondaryWeapon = weapon
	emit_signal("weaponChanged", Enums.WEAPONSLOT.SECONDARY, secondaryWeapon)

	setCurrentWeaponSlot(currentWeaponSlot)

func setTertiaryWeapon(weapon):
	tertiaryWeapon = weapon
	emit_signal("weaponChanged", Enums.WEAPONSLOT.TERTIARY, tertiaryWeapon)
	
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
	if not hasMoved && GameData.chosen_map == "Tutorial" && GameData.current_level == 1:
		GameData.hud.get_node("TutorialTextPrompts").get_child(0).set_text("Move into\nenemies\nto attack.")
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(768, 768) && GameData.current_level == 1 && !applePickedUp && !appleWalkedInto:
		appleWalkedInto = true
		GameData.addTutorialTextIfTutorial("Careful!\nEnemies move\ninto you\nto attack.", Vector2(5.2, 3))
		GameData.hud.get_node("TutorialTextPrompts").get_child(2).set_text("To Pick up,\nClick The\nFloating icon.\nThis Uses up\nA Turn.")
		GameData.hud.get_node("TutorialTextPrompts").get_child(2).set_position(Vector2(7, 6.1) * GameData.TileSize)
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(640, -512) && GameData.current_level == 1:
		GameData.addTutorialTextIfTutorial("Click The\nPopup To \nGo To The\nNext Level.", Vector2(4.6, -5.5))
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(512, 1152) && GameData.current_level == 2 and not offhandWeaponMessageShown:
		offhandWeaponMessageShown = true
		GameData.addTutorialTextIfTutorial("Some Weapons\nWork Best\nIn Your\nOff-hand.", Vector2(1.2, 8.1))
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(384, 1024) && GameData.current_level == 2 and not rarityWeaponMessageShown:
		rarityWeaponMessageShown = true
		GameData.addTutorialTextIfTutorial("Weapons Have\nDifferent Rarities.\nBlue is Best,\nThen Green;\nWorst Is Grey.", Vector2(1.8, 6))
	
	if GameData.chosen_map == "Tutorial" && target_pos == Vector2(640, 768) && GameData.current_level == 2 and not goodLuckMessageShown:
		goodLuckMessageShown = true
		GameData.addTutorialTextIfTutorial("Good luck,\nand have fun.", Vector2(4.7, 5.3))

func _input(ev):
	if ev is InputEventKey and not ev.echo and (OS.get_ticks_msec() - lastdone) > 50:
		if ev.scancode == KEY_LEFT:
			swiped(Enums.DIRECTION.LEFT)
		elif ev.scancode == KEY_RIGHT:
			swiped(Enums.DIRECTION.RIGHT)
		elif ev.scancode == KEY_UP:
			swiped(Enums.DIRECTION.UP)
		elif ev.scancode == KEY_DOWN:
			swiped(Enums.DIRECTION.DOWN)
		
		lastdone = OS.get_ticks_msec()

func swiped(direction):
	moveStack = [direction]
	#if not (moving or charactersAwaitingMove or GameData.charactersMoving()):
	#	lastDirection = direction
	#	forceTurnEnd(direction)

func MoveCharacters():
	charactersAwaitingMove = false
	
	#this includes the player
	for i in range(GameData.characters.size()):
		if i < GameData.characters.size():
			GameData.characters[i].turn()
			# Ensure the character hasn't died during the turn and been removed
			if len(GameData.characters) > i:
				GameData.characters[i].setTurnAnimations()

func attack(character, isFirstCollision, base_damage = 0):
	moveStack = []
	if alive():
		var currentWeapon = getCurrentWeapon()
		var offhandWeapon = getOffHandWeapon()
		
		if currentWeapon.ammo != 0:
			currentWeapon.onAttack(character, lastDirection, isFirstCollision)

			if currentWeapon.doesDamage:
				.attack(character, isFirstCollision, currentWeapon.damage)
			
			if character.character_name == "Training Dummy" && not character.alive() && GameData.current_level == 1:
				GameData.addTutorialTextIfTutorial("Move on\nitems to\npick up.", Vector2(7, 6.2))
			
			GameData.hud.get_node("HudCanvasLayer/WeaponSlots").updateAmmo(currentWeaponSlot, currentWeapon.ammo)
			
			if currentWeapon.ammo == 0:
				removeCurrentWeapon()
		else:
			removeCurrentWeapon()
		
		var dagger = getDaggerIfEquipt()

		if dagger != null && currentWeapon.isMelee && randi() % 3 == 1 && target_pos == character.target_pos:
			.attack(character, isFirstCollision, dagger.damage)
	
	additionalRelativeAttackPositions = getCurrentWeapon().relativeAttackPositions
	currentWeaponNode.set_rotation(getCurrentWeapon().rotationInHand)

func getDaggerIfEquipt():
	if primaryWeapon is Constants.WeaponClasses.CommonDagger:
		return primaryWeapon
	elif secondaryWeapon is Constants.WeaponClasses.CommonDagger:
		return secondaryWeapon
	elif tertiaryWeapon is Constants.WeaponClasses.CommonDagger:
		return tertiaryWeapon
	else:
		return null

func removeCurrentWeapon():
	setCurrentWeapon(Constants.WeaponClasses.Unarmed.new())
	swapWeapons()

func displayArrowsOverMoveStack():
	for n in GameData.hud.get_node("DirectionArrows").get_children():
		GameData.hud.get_node("DirectionArrows").remove_child(n)
		n.queue_free()
	if moveStack.size() > 1:
		var pos = PositionHelper.getNextTargetPos(turn_end_pos / Vector2(GameData.TileSize, GameData.TileSize), moveStack[moveStack.size()-1]) * Vector2(GameData.TileSize, GameData.TileSize) + Vector2(GameData.TileSize / 2, GameData.TileSize / 2)
			
		for i in range(moveStack.size()-2, 0, -1):
			var arrowNode = DirectionArrow.instance()
			
			pos = PositionHelper.getNextTargetPos(pos / Vector2(GameData.TileSize, GameData.TileSize), moveStack[i]) * Vector2(GameData.TileSize, GameData.TileSize)
			
			arrowNode.set_position(pos)
	
			arrowNode.setDirection(moveStack[i-1])
	
			GameData.hud.get_node("DirectionArrows").add_child(arrowNode)

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
		displayArrowsOverMoveStack()
		
		time_elapsed += delta
		emit_signal("turnTimeChange", time_elapsed)
		if time_elapsed >= 1 && GameData.currentGameModeUsesTimer():
			# forefit turn
			time_elapsed = 0
			moveDirection(Enums.DIRECTION.NONE)
			MoveCharacters()

func takeDamage(damage):
	moveStack = []
	var damageableStore = damageable

	shieldOnDamageUsedForTurn = false

	primaryWeapon.onPlayerDamaged()
	secondaryWeapon.onPlayerDamaged()
	tertiaryWeapon.onPlayerDamaged()
	
	if GameData.chosen_map == "Tutorial" || "Test" in GameData.chosen_map:
		damage = min(damage, stats.health.value - 0.5)
	
	if (damage >= stats.health.value && stats.health.value > 2):
		damage = stats.health.value - 0.5
	
	damage = .takeDamage(damage)
	damageable = damageableStore
	
	return damage

func handleCharacterDeath():
	endGame()
	currentWeaponNode.hide()
	offHandWeaponNode.hide()
	get_node("Polygons").hide()
	.handleCharacterDeath()

func endGame():
	GameData.delete_saved_game()
	GameAnalytics.queue_design_event("GamePlay:monsters_killed", GameData.player_kills)

func revive():
	.revive()
	emit_signal("statsChanged", "health", "Up", stats.health.value)
	currentWeaponNode.show()
	offHandWeaponNode.show()
	get_node("Polygons").show()

func pickUpTopItem():
	pickUp(GameData.itemAtPos(self.get_position()/GameData.TileSize))
	
func pickUpWeapon(weapon):
	if not primaryWeapon.equiptable:
		setPrimaryWeapon(weapon)
	elif not secondaryWeapon.equiptable:
			setSecondaryWeapon(weapon)
	elif not tertiaryWeapon.equiptable && GameData.player.thirdWeaponSlot:
			setTertiaryWeapon(weapon)
	else:
		dropWeapon()
		setCurrentWeapon(weapon)

func pickUp(item):
	if (item != null):
		item.pickup()
		emit_signal("itemPickedUp", item)
		
		if GameData.chosen_map == "Tutorial" && item.item_name == "Apple" && GameData.current_level == 1:
			applePickedUp = true
			GameData.hud.get_node("TutorialTextPrompts").get_child(2).set_text("Click the food\nicon at the\nbottom to eat.")
			GameData.hud.get_node("TutorialTextPrompts").get_child(2).set_position(Vector2(7, 6.1) * GameData.TileSize)
		
		if GameData.chosen_map == "Tutorial" && item.item_name == "Bomb" && GameData.current_level == 2:
			GameData.hud.get_node("TutorialTextPrompts").get_child(0).set_text("Click the weapon\nyou want to\nequip on the\nbottom left icons")

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
	if readyToTeleportOnTileSelect:
		teleportToTile(event)
	else:
		moveToTile(event)

func pathToDirectionPath(path):
	var directionPath = []
	for i in range(0, len(path) - 1):
		var direction_vector = path[i + 1] - path[i]
		if direction_vector.x == 1:
			directionPath.push_front(Enums.DIRECTION.RIGHT)
		elif direction_vector.x == -1:
			directionPath.push_front(Enums.DIRECTION.LEFT)
		elif direction_vector.y == 1:
			directionPath.push_front(Enums.DIRECTION.DOWN)
		elif direction_vector.y == -1:
			directionPath.push_front(Enums.DIRECTION.UP)
	return directionPath

func moveToTile(event = null):
	var tilePosition = (event.position + (get_node("Camera2D").get_camera_screen_center()) - half_screen_size) / GameData.TileSize
	var tilePositionRounded = Vector2(floor(tilePosition.x), floor(tilePosition.y))
	var player_pos = (GameData.player.turn_end_pos) / GameData.TileSize
	var path = GameData.tilemap.findPath(player_pos, tilePositionRounded)
	moveStack = pathToDirectionPath(path)

func performMoveStack(t):
	if len(moveStack) > 0 and not (moving or charactersAwaitingMove):
		var direction = moveStack.pop_back()
		lastDirection = direction
		forceTurnEnd(direction)

func teleportToTile(event = null):
	if event == null:
		event = lastEvent
	else:
		lastEvent = event
	
	if moving or charactersAwaitingMove or GameData.charactersMoving():
		self.connect("turnEnd", self, "gameClickableRegionClicked", [], CONNECT_ONESHOT)
		return

	moveStack = []

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
