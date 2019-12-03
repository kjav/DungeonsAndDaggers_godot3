extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Baby Ogre'
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.5, "value": Constants.FoodClasses.CookedSteak}])

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 3
	turnBehaviour.setWaitEvery(3)

	._ready()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()