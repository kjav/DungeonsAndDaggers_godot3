extends "StatusEffectBase.gd"

func _init():
	texture = preload("res://assets/red_simple_potion.webp")
	effectName = "Temporary Health"
	effectDescription = "You have extra temporary health for the duration of this effect. If any of the temporary health remains by the end it will be removed."