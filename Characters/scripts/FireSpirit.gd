extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Fire Spirit'
	item_distribution = Constants.Distribution.new([{"p": 0.05, "value": Constants.PotionClasses.BriefStrengthPotion}, {"p": 0.15, "value": Constants.FoodClasses.Apple}, {"p": 0.05, "value": Constants.SpellClasses.MissileSpell}])

func _ready():
	turnBehaviour = Turn.MoveUpRightDownLeft.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 1
	
	initialStats.health = {
		"value": 2,
		"maximum": 2
	}

	._ready()