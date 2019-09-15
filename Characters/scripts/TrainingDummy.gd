extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.Wait.new()
	processBehaviour = Process.Direct.new()
	self.character_name = 'Training Dummy'
	base_damage = 0
	
	initialStats.health = {
		"value": 3e+37,
		"maximum": 3e+37
	}

	._ready()