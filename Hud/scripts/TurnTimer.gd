extends Node2D

func _ready():
	GameData.player.connect("turnTimeChange", self, "timeChange")

func timeChange(time_elapsed):
	var desiredFrame = floor( time_elapsed / 1 * 20 )
	
	self.get_node("Turn Timer").set_frame(desiredFrame)