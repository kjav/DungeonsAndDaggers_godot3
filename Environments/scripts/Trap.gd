extends "EnvironmentBase.gd"

var activated = false

func _ready():
	walkable = Enums.WALKABLE.ALL

func onWalkedInto(character):
	if !character.trapImmune && !activated:
			activated = true
			self.animation = "active"
			character.takeDamage(randi()%2 / float(2))
			character.takeDamage(randi()%2 / float(2))
			character.takeDamage(randi()%2 / float(2))
