extends "SpellBase.gd"

func _init():
	iconFilePath = "res://assets/rune_spell.webp"
	item_name = "Stun"
	texture = preload("res://assets/rune_spell.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return

	var closest_enemy = GameData.closestEnemy()
	
	if closest_enemy and GameData.player.consume_stat("mana", 0.5):
		.onUse()
		closest_enemy.addStun(randi()%2+2)
	else:
		GameData.hud.addEventMessage("No target in range")
