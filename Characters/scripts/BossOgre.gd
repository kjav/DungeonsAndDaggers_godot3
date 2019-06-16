extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.MoveToWaitBeforeAndAfterAttack.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Boss Ogre'
	base_damage = 3
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.CookedSteak}])
	
	initialStats.health = {
		"value": 12,
		"maximum": 12
	}
	
	._ready()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()