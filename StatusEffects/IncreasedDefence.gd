extends "StatusEffectBase.gd"

func _init():
	texture = preload("res://assets/black_simple_potion.webp")
	effectName = "Increased Defence"
	effectDescription = "Defence is higher for the duration of this effect. Defence makes damage taken hit, on average, lower."