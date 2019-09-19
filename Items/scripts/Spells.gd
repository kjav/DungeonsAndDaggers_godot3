class FireSpell extends "SpellBase.gd":
	const missile = preload("res://Projectiles/Missile.tscn")
	const missile_texture = preload("res://assets/fireball.png")

	func _init():
		iconFilePath = "res://assets/red_spell2.png"
		description = "Shoot a fire ball at the closest enemy!"
		item_name = "Fire Spell"
		texture = preload("res://assets/red_spell2.png")

	func onUse():
		var closest_enemy = GameData.closestEnemy()
		if closest_enemy:
			# Remove potion
			if GameData.player.consume_stat("mana", 1):
				.onUse()
				launchFireball(closest_enemy)
				GameData.spells.remove(GameData.spells.find(self))

	func launchFireball(closest_enemy):
		var new_missile = missile.instance()
		#Audio.playSoundEffect("Fireball_Flying")
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			closest_enemy.get_path(),
			missile_texture,
			GameData.player.get_position(),
			25,
			10,
			"Fireball_Hit",
			Vector2(4, 4)
		)
