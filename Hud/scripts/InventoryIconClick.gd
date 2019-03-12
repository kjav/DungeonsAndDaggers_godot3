extends TextureButton

func _pressed():
	var parent = self.get_parent()
	parent.queue_free()
	parent.instance.onUse()
	parent.hide()
	parent.get_parent().selectItem(parent)
	#needs to remove from gamedata list

