extends "StatusEffectBase.gd"

func _init():
	texture = preload("res://assets/green_simple_potion.webp")
	effectName = "Increased Strength"
	effectDescription = "Strength is higher for the duration of this effect. Strength makes damage hit, on average, higher."