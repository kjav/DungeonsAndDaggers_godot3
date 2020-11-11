extends Node2D

func updateHealth(health):
	if health != null:
		get_node("TextureRect").set_size(Vector2(health * 2, 2))
		get_node("TextureRect").set_position(Vector2(-health, -2))
