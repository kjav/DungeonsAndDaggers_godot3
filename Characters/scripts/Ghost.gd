extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Ghost'
	item_distribution = Constants.Distribution.new([
		{"p": 0.07, "value": Constants.UncommonFoodsDistribution.pick()[0].value}, 
		{"p": 0.05, "value": Constants.CommonFoodsDistribution.pick()[0].value}, 
		{"p": 0.025, "value": Constants.PotionClasses.InvisibilityPotion },
		{"p": 0.025, "value": Constants.CommonPotionsDistribution.pick()[0].value },
		{"p": 0.03, "value": Constants.UncommonPotionsDistribution.pick()[0].value },
		{"p": 0.025, "value": Constants.CommonSpellsDistribution.pick()[0].value },
		{"p": 0.025, "value": Constants.UncommonSpellsDistribution.pick()[0].value },
	])

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomEveryNTurnsInvinsibleOnWait.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 2
	turnBehaviour.setTurnWait(1)
	undamageableAnimationName = "invinsible"
	
	initialStats.health = {
		"value": 4,
		"maximum": 4
	}

	initialStats.strength = {
		"value": 4,
		"maximum": 4
	}

	initialStats.defence = {
		"value": 2,
		"maximum": 2
	}

func turn(skipTurnBehaviour = false):
	.turn()    
	self.damageable = turnBehaviour.getDamageable()
	
