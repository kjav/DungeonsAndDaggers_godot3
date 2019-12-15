extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Fire Spirit'
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.SpellClasses.FireSpell}])

func _ready():
	turnBehaviour = Turn.MoveUpLeftDownRight.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 2
	
	._ready()