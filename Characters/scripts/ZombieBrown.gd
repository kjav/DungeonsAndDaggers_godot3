extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Zombie'

	item_distribution = Constants.Distribution.new([
		{"p": 0.1, "value": Constants.DistributionOfEquals.new([{ "value": Constants.PotionClasses.BriefStrengthPotion }, { "value": Constants.CommonPotionsDistribution.pick()[0].value }]).pick()[0].value}, 
		{"p": 0.15, "value": Constants.CommonFoodsDistribution.pick()[0].value}, 
		{"p": 0.05, "value": Constants.DistributionOfEquals.new([{ "value": Constants.SpellClasses.MissileSpell }, { "value": Constants.CommonSpellsDistribution.pick()[0].value }]).pick()[0].value}
	])

func _ready():
	turnBehaviour = Turn.MoveUpRightDownLeft.new(self)
	processBehaviour = Process.Direct.new()
	
	setBaseDamage(1)
	setInitialHealth(1, 1, 1)
	setInitialStats(2, 2, 1, 1)

	._ready()
