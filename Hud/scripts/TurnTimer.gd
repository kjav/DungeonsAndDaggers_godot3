extends Node2D

const timePerTurn = 1
var timerNode

func _ready():
	GameData.player.connect("turnTimeChange", self, "timeChange")
	timerNode = self.get_node("Turn Timer")

func timeChange(timeElapsed):
	var desiredFrame = floor( timeElapsed / timePerTurn * (timerNode.frames.get_frame_count("default") - 1) )
	
	timerNode.set_frame(desiredFrame)
