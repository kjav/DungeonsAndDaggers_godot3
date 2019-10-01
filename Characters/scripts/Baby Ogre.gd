extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	self.character_name = 'Baby Ogre'
	base_damage = 3
	turnBehaviour.setWaitEvery(3)
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.5, "value": Constants.FoodClasses.CookedSteak}])

	._ready()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()