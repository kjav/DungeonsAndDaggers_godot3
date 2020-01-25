extends "WeaponBase.gd"

const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/arrow.png")

func _init():
	iconFilePath = "res://assets/basic_bow.png"
	texture = preload("res://assets/basic_bow.png")
	item_name = "Common Bow"
	relativeAttackPositions = [Vector2(0, -1), Vector2(0, -2), Vector2(0, -3), Vector2(0, -4), Vector2(0, -5)]
	damage = 1
	onlyAttacksFirstEnemy = true
	showBehindHand = true
	offset = Vector2(10, 22)
	rotationInHand = deg2rad(185)
	rotationInOffHand = deg2rad(145)
	ammo = 4

func onAttack(target):
	if target:
		var new_missile = missile.instance()
		#Audio.playSoundEffect("Arrow_Shot")
		GameData.player.get_parent().add_child(new_missile)
		
		new_missile.init(
			target,
			missile_texture,
			GameData.player.getPrimaryHandPosition(),
			25,
			0,
			"Arrow_Hit",
			Vector2(0.5, 0.5),
			false
		)
		
		.onAttack(target)
