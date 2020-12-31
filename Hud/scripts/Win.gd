extends "OverlayMenu.gd"

func fadeIn():
	get_node("confetti").emitting = true
	get_node("confetti").restart()
	get_node("confetti").show()
	
	.fadeIn()
