extends TextureButton

func _pressed():
	self.get_parent().set("progress", self.get_parent().get("progress") - 1)
