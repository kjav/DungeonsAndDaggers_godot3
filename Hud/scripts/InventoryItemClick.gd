extends "ItemPopupBaseScript.gd"

func _init():
	popupPosition = "left"

func actionShortPress():
	var parent = self.get_parent()
	
	parent.queue_free()
	parent.hide()
	parent.get_parent().selectItem(parent)
	parent.instance.onUse()

func getItem():
	return get_parent().getInstance()