extends "Enemy.gd"

const Stairs = preload("res://Environments/LevelStairs.tscn")

func handleCharacterDeath():
	var anyRemainingBosses = anyOtherBossesRemaining()
	
	if !anyRemainingBosses:
		var Environments = self.get_node("/root/Node2D/Environments")
		var node = Stairs.instance()
		node.set_position(position)
		Environments.add_child(node)
		GameData.environmentObjects.append(node)
	
	# TODO: Change how boss items are dropped so they're not on the stairs
	.handleCharacterDeath()

func anyOtherBossesRemaining():
	var a = load(get_script().get_path())
	for character in GameData.characters:
		if character != self:
			if character is a:
				return true
	
	return false