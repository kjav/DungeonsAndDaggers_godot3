extends "EnvironmentBase.gd"

var activated = false

func _ready():
	walkable = Enums.WALKABLE.ALL

func onWalkedInto(character):
	if character == GameData.player:
		if not activated:
			activated = true
			self.animation = "active"
			character.takeDamage(0.5)
			character.takeDamage(0.5)
			character.takeDamage(0.5)

