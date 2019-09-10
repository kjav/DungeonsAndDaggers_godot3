extends "Enemy.gd"

const Stairs = preload("res://Environments/LevelStairs.tscn")

func handleCharacterDeath():
	var Environments = self.get_node("/root/Node2D/Environments")
	var node = Stairs.instance()
	node.set_position(position)
	Environments.add_child(node)
	GameData.environmentObjects.append(node)
	# TODO: Change how boss items are dropped so they're not on the stairs
	.handleCharacterDeath()
