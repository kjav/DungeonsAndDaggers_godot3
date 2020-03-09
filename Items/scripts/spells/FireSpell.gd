extends "SpellBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/fireball.webp")

func _init():
	textureFilePath = "res://assets/red_spell2.webp"
	item_name = "Fire"
	texture = preload("res://assets/red_spell2.webp")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	var closest_enemy = GameData.closestEnemy()
	
	if closest_enemy and GameData.player.consume_stat("mana", 1):
			launchFireball(closest_enemy)
			.onUse()
	else:
		GameData.hud.addEventMessage("No target in range")

func launchFireball(closest_enemy):
	var new_missile = missile.instance()
	#Audio.playSoundEffect("Fireball_Flying")
	GameData.player.get_parent().add_child(new_missile)
	
	new_missile.init(
		GameData.player,
		closest_enemy,
		missile_texture,
		GameData.player.get_position(),
		25,
		randi() % 3 + 8,
		"Fireball_Hit",
		Vector2(4, 4),
		true,
		false
	)
