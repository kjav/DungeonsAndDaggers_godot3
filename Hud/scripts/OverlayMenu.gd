extends Control

func fadeIn():
	show()
	get_node("AnimationPlayer").play("death screen fade in")

func reset():
	get_node("Buttons/ReviveButton").reset()
