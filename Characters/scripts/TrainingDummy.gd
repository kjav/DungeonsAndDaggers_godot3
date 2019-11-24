extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.Wait.new(self)
	processBehaviour = Process.Direct.new()
	self.character_name = 'Training Dummy'
	base_damage = 0
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.Apple}])
	
	initialStats.health = {
		"value": 9,
		"maximum": 9
	}

	._ready()