extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandom.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Bat'
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.WeaponClasses.BasicShield }, { "p": 0.1, "value": Constants.PotionClasses.HealthPotion}])
