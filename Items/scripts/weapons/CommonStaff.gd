extends "WeaponBase.gd"
const HeavyImpact = preload("res://VisualEffects/HeavyImpact.tscn")
var nextAttackForward = true

func _init():
	._init()
	textureFilePath = "res://assets/Staves/basic_staff.png"
	texture = preload("res://assets/Staves/basic_staff.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/Staves/basic_staff_icon.png"
	iconTexture = preload("res://assets/Staves/basic_staff_icon.png")
	item_name = "Common Staff"
	item_description = "Staves alternate between additionally attacking behind or to the sides of the target. Common has a base damage of 1.5."
	rarity = Enums.WEAPONRARITY.COMMON
	isMelee = true
	showBehindHand = true
	damage = 1.5
	attackPositionBlockable = false
	onlyAttacksFirstEnemy = false
	offset = Vector2(-30, -50)
	toggleRelativeAttackPositions()

func onAttack(target, attackDirection, isFirstCollision):
	if isFirstCollision:
		addHeavyImpacts(attackDirection)
		toggleRelativeAttackPositions()
	
	.onAttack(target, attackDirection, isFirstCollision)

func toggleRelativeAttackPositions():
	if nextAttackForward:
		relativeAttackPositions = [Vector2(0, -1)]
		rotationInHand = deg2rad(35)
	else:
		relativeAttackPositions = [Vector2(-1, 0), Vector2(1, 0)]
		rotationInHand = deg2rad(0)

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
