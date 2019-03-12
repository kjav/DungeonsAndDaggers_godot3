extends Node2D

func setTexture(texture):
	get_node("KeyIcon").set_texture(texture)
	
func setPosition(keyNumber):
	var position = Vector2(keyNumber * (get_node("KeyIcon").get_texture().get_width() + 1), 0)
	get_node("KeyIcon").set_position(position)
