extends Node2D

func explode():
	get_node("AnimatedSprite").set_frame(0)
	get_node("AnimatedSprite").play()

func setSpeedScale(value):
	get_node("AnimatedSprite").set_speed_scale(value)
