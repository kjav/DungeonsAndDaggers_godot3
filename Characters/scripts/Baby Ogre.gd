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
	turnBehaviour.setWaitEvery(3)
	
	setBaseDamage(1.5)
	setInitialHealth(1.5, 1.5)
	setInitialStats(2, 2, 2, 2)

	._ready()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()
