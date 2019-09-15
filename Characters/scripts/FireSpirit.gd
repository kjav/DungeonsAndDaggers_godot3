extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.MoveUpRightDownLeft.new()
	processBehaviour = Process.Bounce.new()
	self.character_name = 'Fire Spirit'
	base_damage = 2
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.SpellClasses.FireSpell}])

	._ready()