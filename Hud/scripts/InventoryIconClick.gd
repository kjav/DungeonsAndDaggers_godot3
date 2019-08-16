extends TextureButton

func _pressed():
	var parent = self.get_parent()
	parent.queue_free()
	parent.hide()
	parent.get_parent().selectItem(parent)
	parent.instance.onUse()
	#needs to remove from gamedata list

