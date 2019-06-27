extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Baby Ogre'
	base_damage = 3
	turnBehaviour.setWaitEvery(3)
	turnBehaviour.init()
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.5, "value": Constants.FoodClasses.CookedSteak}])
