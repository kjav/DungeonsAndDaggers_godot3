extends Node2D

func hidePopup():
	hide()
	queue_free()

func setPopupPosition(mousePosition):
	set_position(mousePosition)