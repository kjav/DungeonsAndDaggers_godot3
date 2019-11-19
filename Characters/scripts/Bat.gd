extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandom.new(self)
	processBehaviour = Process.Direct.new()
	self.character_name = 'Bat'
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.WeaponClasses.CommonShield }, { "p": 0.1, "value": Constants.PotionClasses.HealthPotion}])
