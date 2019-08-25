extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomEveryNTurnsInvinsibleOnWait.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Ghost'
	base_damage = 2
	turnBehaviour.setTurnWait(2)
	turnBehaviour.init()
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.1, "value": Constants.SpellClasses.FireSpell}])
	undamageableAnimationName = "invinsible"

func turn():
	.turn()    
	self.damageable = turnBehaviour.getDamageable()
	
