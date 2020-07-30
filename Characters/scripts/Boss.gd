extends "Enemy.gd"

const Stairs = preload("res://Environments/LevelStairs.tscn")
var boss = load(get_script().get_path())

func handleCharacterDeath():
	var anyRemainingBosses = anyOtherBossesRemaining()
	
	if deathWinConditionMet():
		GameData.hud.get_node("HudCanvasLayer/WinMenu").fadeIn()
	elif !anyRemainingBosses:
		var Environments = self.get_node("/root/Node2D/Environments")
		var node = Stairs.instance()
		node.set_position(position)
		Environments.add_child(node)
		GameData.environmentObjects.append(node)
	
	.handleCharacterDeath()

func anyOtherBossesRemaining():
	for character in GameData.characters:
		if character != self:
			if character is boss:
				return true
	
	return false

func deathWinConditionMet():
	return false
