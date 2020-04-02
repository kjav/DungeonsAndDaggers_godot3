extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Baby Ogre'

	item_distribution = Constants.Distribution.new([
		{"p": 0.2, "value": Constants.CommonFoodsDistribution.pick()[0].value},
		{"p": 0.1, "value": Constants.UncommonFoodsDistribution.pick()[0].value},
		{"p": 0.05, "value": Constants.WeaponClasses.OgreArm}
	])

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 2
	turnBehaviour.setWaitEvery(3)
	
	initialStats.health = {
		"value": 4,
		"maximum": 4
	}

	initialStats.strength = {
		"value": 4,
		"maximum": 4
	}

	initialStats.defence = {
		"value": 3,
		"maximum": 3
	}

	._ready()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()
