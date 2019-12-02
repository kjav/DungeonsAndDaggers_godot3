extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Ghost'
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.1, "value": Constants.SpellClasses.FireSpell}])

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomEveryNTurnsInvinsibleOnWait.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 2
	turnBehaviour.setTurnWait(2)
	turnBehaviour.init()
	undamageableAnimationName = "invinsible"

func turn(skipTurnBehaviour = false):
	.turn()    
	self.damageable = turnBehaviour.getDamageable()
	
