extends "TimerBase.gd"

const timePerTurn = 1

func _ready():
	GameData.player.connect("turnTimeChange", self, "timeChange")

func timeChange(timeElapsed):
	var proportion = timeElapsed / timePerTurn
	
	#slightly higher than 360 so that it looks like a small pause between turn end and start
	degrees = min(floor(proportion * 1.1 * 360), 360)
	#slight higher than 1-propotion (scaled from yellow to red) to allow period of yellow before it starts fading to redish
	colour = Color(1,1.3-proportion,0)
	
	update()