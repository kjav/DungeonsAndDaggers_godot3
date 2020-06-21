extends Control

func fadeIn():
	show()
	get_node("AnimationPlayer").play("death screen fade in")
