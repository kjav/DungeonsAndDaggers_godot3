extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Bat'

	item_distribution = Constants.Distribution.new([
		{"p": 0.2, "value": Constants.CommonFoodsDistribution.pick()[0].value},
		{"p": 0.05, "value": Constants.UncommonFoodsDistribution.pick()[0].value}
	])
	
	base_damage = 1
	
	initialStats.health = {
		"value": 2,
		"maximum": 2
	}

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandom.new(self)
	processBehaviour = Process.Direct.new()
