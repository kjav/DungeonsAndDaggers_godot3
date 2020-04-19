extends "WeaponBase.gd"
const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
var nextAttackForward = true

func _init():
	textureFilePath = "res://assets/meat_club.png"
	texture = preload("res://assets/meat_club.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/meat_club.png"
	iconTexture = preload("res://assets/meat_club.png")
	item_name = "Ogre Arm"
	item_description = "The ogre arm swaps between attacking infront or to the side of the attacked tile with base of 3 damage."
	rarity = Enums.WEAPONRARITY.RARE
	isMelee = true
	showBehindHand = true
	damage = 3
	attackPositionBlockable = false
	onlyAttacksFirstEnemy = false
	offset = Vector2(-35, -35)
	rotationInOffHand = deg2rad(55)
	toggleRelativeAttackPositions()

func onAttack(target, attackDirection, isFirstCollision):
	if isFirstCollision:
		addHeavyImpacts(attackDirection)
		toggleRelativeAttackPositions()
	
	.onAttack(target, attackDirection, isFirstCollision)

func toggleRelativeAttackPositions():
	if nextAttackForward:
		relativeAttackPositions = [Vector2(0, -1)]
		rotationInHand = deg2rad(120)
	else:
		relativeAttackPositions = [Vector2(-1, 0), Vector2(1, 0)]
		rotationInHand = deg2rad(180)

	nextAttackForward = !nextAttackForward

func addHeavyImpacts(attackDirection):
	GameData.player.get_node("Camera2D").shake(0.1, 20, 20)
	
	var attackPositions = [GameData.player.target_pos] + PositionHelper.absoluteAttackPositions(GameData.player.target_pos / GameData.TileSize, relativeAttackPositions, attackDirection)
	
	for attackPosition in attackPositions:
		displayHeavyImpact(attackPosition * GameData.TileSize)

func displayHeavyImpact(position):
	var heavyImpactInstance = HeavyImpact.instance()
	
	heavyImpactInstance.position = position
	GameData.effectsNode.add_child(heavyImpactInstance)
	heavyImpactInstance.play()

func convertToAbsolutePosition(attackPositions):
	for i in range(attackPositions.size()):
		attackPositions[i] *= GameData.TileSize
		attackPositions[i] += GameData.player.position
	
	return attackPositions