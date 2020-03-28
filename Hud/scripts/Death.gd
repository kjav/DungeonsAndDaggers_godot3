extends Control

func died():
	show()
	get_node("AnimationPlayer").play("death screen fade in")
