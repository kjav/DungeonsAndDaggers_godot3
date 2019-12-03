extends Label

func set_text(text):
	self.text = text
	get_node("Background").set_size(self.get_minimum_size() + Vector2(4, 4))