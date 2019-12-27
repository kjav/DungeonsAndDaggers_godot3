extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Bat'

	item_distribution = Constants.Distribution.new([
		{"p": 0.2, "value": Constants.CommonFoodsDistribution.pick()[0].value},
		{"p": 0.05, "value": Constants.UncommonFoodsDistribution.pick()[0].value}
	])

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandom.new(self)
	processBehaviour = Process.Direct.new()

	base_damage = 1
	
	initialStats.health = {
		"value": 1,
		"maximum": 1
	}

	initialStats.strength = {
		"value": 1,
		"maximum": 1
	}

	initialStats.defence = {
		"value": 3,
		"maximum": 3
	}

	._ready()