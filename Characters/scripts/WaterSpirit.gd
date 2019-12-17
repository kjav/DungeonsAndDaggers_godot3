extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Fire Spirit'
	item_distribution = Constants.Distribution.new([
		{"p": 0.05, "value": Constants.PotionClasses.BriefDefencePotion}, 
		{"p": 0.15, "value": Constants.FoodClasses.Apple}, 
		{"p": 0.05, "value": Constants.SpellClasses.StunSpell}
	])

func _ready():
	turnBehaviour = Turn.MoveUpLeftDownRight.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 0.5
	
	initialStats.health = {
		"value": 3,
		"maximum": 3
	}
	
	._ready()