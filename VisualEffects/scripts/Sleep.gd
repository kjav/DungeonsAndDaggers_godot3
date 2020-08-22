extends Node2D

func playSleep():
	get_node("AnimationPlayer").play("sleep")
	get_node("AnimationPlayer").connect("animation_finished",self,"hide", [], CONNECT_ONESHOT)
