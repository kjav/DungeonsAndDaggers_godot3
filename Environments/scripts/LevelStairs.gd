extends "EnvironmentBase.gd"

func _ready():
	walkable = Enums.WALKABLE.ALL

func onWalkedInto(character):
	if character == GameData.player:
		print("Next Level")
		# TODO: Generate a new dungeon floor here, animating a fade out and fade in to the new dungeon floor
