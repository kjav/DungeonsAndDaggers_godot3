extends "SpellBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/pellet.jpg")

func _init():
	._init()
	textureFilePath = "res://assets/triangle_spell.webp"
	item_name = "Missile"
	item_description = "Deals 2 damage to the closest enemy."
	texture = preload("res://assets/triangle_spell.webp")

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

func spellDamage():
	var damage = 2

	if GameData.player.increasedSpellDamage:
		damage = 3
	
	return damage

func launchPellet(closest_enemy):
	var new_missile = missile.instance()
	#Audio.playSoundEffect("Missile_Flying")
	GameData.player.get_parent().add_child(new_missile)
	
	new_missile.init(
		GameData.player,
		closest_enemy,
		missile_texture,
		GameData.player.get_position(),
		25,
		spellDamage(),
		"Missile_Hit",
		Vector2(0.2, 0.2),
		true,
		false
	)
