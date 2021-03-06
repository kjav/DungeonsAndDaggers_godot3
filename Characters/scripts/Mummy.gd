extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Mummy'

	item_distribution = Constants.Distribution.new([
		{"p": 0.2, "value": Constants.CommonFoodsDistribution.pick()[0].value},
		{"p": 0.1, "value": Constants.UncommonFoodsDistribution.pick()[0].value},
		{"p": 0.05, "value": Constants.RareWeaponsDistribution.pick()[0].value}
	])

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	turnBehaviour.setWaitEvery(3)
	turnBehaviour.waitEveryN.shouldStunInsteadOfWait = true
	turnBehaviour.setLimit(6)
	
	setBaseDamage(1)
	setInitialHealth(3.5, 3.5, 2.5)
	setInitialStats(2, 2, 2, 2)

	._ready()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()
