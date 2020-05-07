extends "SpellBase.gd"

func _init():
	textureFilePath = "res://assets/rune_spell.webp"
	item_name = "Stun"
	item_description = "Stuns the closest enemy for 2-4 turns."
	texture = preload("res://assets/rune_spell.webp")

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
