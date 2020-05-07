extends "StatusEffectBase.gd"

func _init():
	texture = preload("res://assets/clear_potion.webp")
	effectName = "Invisible"
	effectDescription = "You are invisible for the duration of this effect. Enemies won't be able to see you but can still bump into you by accident!"