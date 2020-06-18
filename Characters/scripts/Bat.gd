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
	
	setBaseDamage(0.5)
	setInitialStats(0.5, 0.5, 1.5, 1.5, 0.5, 0.5)

	._ready()
