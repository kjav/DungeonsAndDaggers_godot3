extends "StatusEffectBase.gd"

func _init():
	texture = preload("res://assets/black_potion.webp")
	effectName = "Double Damage"
	effectDescription = "Your attacks deal double the damage they normally would for the duration of this effect."