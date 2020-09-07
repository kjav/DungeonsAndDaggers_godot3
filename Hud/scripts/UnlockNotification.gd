extends Node2D

func setUnlockText(text):
	get_node("TextureRect/Label").text = text

func showUnlock():
	get_node("sparkle").restart()
	get_node("AnimationPlayer").play("unlock")
