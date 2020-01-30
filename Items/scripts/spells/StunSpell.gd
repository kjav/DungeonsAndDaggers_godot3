extends "SpellBase.gd"

func _init():
	textureFilePath = "res://assets/rune_spell.png"
	item_name = "Stun"
	texture = preload("res://assets/rune_spell.png")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return

	var closest_enemy = GameData.closestEnemy()
	
	if closest_enemy and GameData.player.consume_stat("mana", 0.5):
		closest_enemy.addStun(randi()%2+2)
		.onUse()
	else:
		GameData.hud.addEventMessage("No target in range")
