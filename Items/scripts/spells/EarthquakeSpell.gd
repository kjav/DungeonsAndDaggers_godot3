extends "SpellBase.gd"

const HeavyImpact = preload("res://VisualEffects/HeavyImpact.tscn")

func _init():
	._init()
	textureFilePath = "res://assets/brown_spell.webp"
	item_name = "Earthquake"
	item_description = "Deals 3 damage to all enemies within 2 tiles of you."
	texture = preload("res://assets/brown_spell.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	var enemiesInArea = GameData.getCharactersWithinAreaAroundCharacter(GameData.player, 2)
	
	if enemiesInArea.size() > 0 and GameData.player.consume_stat("mana", 1):
		addHeavyImpacts()
		GameData.player.get_node("Camera2D").shake(0.2, 50, 50)
		damageEnemies(enemiesInArea)
		.onUse()
	else:
		GameData.hud.addEventMessage("No targets in range")

func damageEnemies(enemiesInArea):
	for enemy in enemiesInArea:
		enemy.takeDamage(spellDamage())

func spellDamage():
	var damage = 3

	if GameData.player.increasedSpellDamage:
		damage = 3.5
	
	return damage


func addHeavyImpacts():
	var attackPositions = PositionHelper.getRelativeCoordinatesAroundPoint(1)
	var attackPositions2 = PositionHelper.getRelativeCoordinatesAroundPoint(2)
	
	attackPositions = convertToAbsolutePosition(attackPositions)
	attackPositions2 = convertToAbsolutePosition(attackPositions2)
	
	displayHeavyImpacts(attackPositions)
	
	var timer = Timer.new()
	timer.set_wait_time(0.2)
	timer.connect("timeout", self, "displayHeavyImpacts", [attackPositions2])
	timer.set_one_shot(true)
	GameData.effectsNode.add_child(timer)
	timer.start()

func convertToAbsolutePosition(attackPositions):
	for i in range(attackPositions.size()):
		attackPositions[i] *= GameData.TileSize
		attackPositions[i] += GameData.player.position
	
	return attackPositions

func displayHeavyImpacts(positions):
	for position in positions:
		var heavyImpactInstance = HeavyImpact.instance()
		
		heavyImpactInstance.position = position
		GameData.effectsNode.add_child(heavyImpactInstance)
		heavyImpactInstance.play()
