extends "SpellBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/pellet.png")

func _init():
	iconFilePath = "res://assets/triangle_spell.png"
	item_name = "Missile"
	texture = preload("res://assets/triangle_spell.png")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return

	var closest_enemy = GameData.closestEnemy()
	
	if closest_enemy and GameData.player.consume_stat("mana", 0.5):
		launchPellet(closest_enemy)
		.onUse()
	else:
		GameData.hud.addEventMessage("No target in range")

func launchPellet(closest_enemy):
	var new_missile = missile.instance()
	#Audio.playSoundEffect("Missile_Flying")
	GameData.player.get_parent().add_child(new_missile)
	
	new_missile.init(
		closest_enemy.get_path(),
		missile_texture,
		GameData.player.get_position(),
		25,
		2,
		"Missile_Hit",
		Vector2(0.2, 0.2)
	)
