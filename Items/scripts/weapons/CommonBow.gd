extends "WeaponBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/arrow.png")

func _init():
	._init()
	textureFilePath = "res://assets/basic_bow.png"
	texture = preload("res://assets/basic_bow.png")
	offhandTexture = texture
	offhandTextureFilePath = textureFilePath
	iconTextureFilePath = "res://assets/basic-bow-icon.png"
	iconTexture = preload("res://assets/basic-bow-icon.png")
	item_name = "Common Bow"
	item_description = "Bows hit the first enemy in a straight line at any distance. Common's base damage is 1 and has at most 6 ammo."
	relativeAttackPositions = [Vector2(0, -1), Vector2(0, -2), Vector2(0, -3), Vector2(0, -4), Vector2(0, -5), Vector2(0, -6), Vector2(0, -7)]
	damage = 0.5
	showBehindHand = true
	offset = Vector2(8, 25)
	rotationInHand = deg2rad(155)

func onAttack(target, attackDirection, isFirstCollision):
	if target:
		var new_missile = missile.instance()
		#Audio.playSoundEffect("Arrow_Shot")
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			GameData.player,
			target,
			missile_texture,
			GameData.player.getPrimaryHandPosition(),
			25,
			0,
			"Arrow_Hit",
			Vector2(0.5, 0.5),
			false,
			false
		)
		
		.onAttack(target, attackDirection, isFirstCollision)
