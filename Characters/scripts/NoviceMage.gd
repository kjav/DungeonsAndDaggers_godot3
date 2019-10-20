extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	self.character_name = 'Novice Mage'
	base_damage = 1
	turnBehaviour.setWaitEvery(2)
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.SpellClasses.MissileSpell}])
	additionalRelativeAttackPositions = [Vector2(-1, 0), Vector2(-1, 1), Vector2(-1, -1), Vector2(-2, 0), Vector2(-2, 1), Vector2(-2, -1)]

	._ready()