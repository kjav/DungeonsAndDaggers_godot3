extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Water Spirit'
	
	item_distribution = Constants.Distribution.new([
		{"p": 0.1, "value": Constants.DistributionOfEquals.new([
				{ "value": Constants.PotionClasses.BriefDefencePotion }, 
				{ "value": Constants.CommonPotionsDistribution.pick()[0].value }
			]).pick()[0].value}, 
		{"p": 0.15, "value": Constants.CommonFoodsDistribution.pick()[0].value}, 
		{"p": 0.05, "value": Constants.DistributionOfEquals.new([{ "value": Constants.SpellClasses.StunSpell }, { "value": Constants.CommonSpellsDistribution.pick()[0].value }]).pick()[0].value}
	])

func _ready():
	turnBehaviour = Turn.MoveUpLeftDownRight.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 0.5
	
	initialStats.health = {
		"value": 4,
		"maximum": 4
	}
	
	._ready()