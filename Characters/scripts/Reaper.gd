extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Reaper'
	hasOnlyRightAnimations = true
	
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
	turnBehaviour.setTurnWait(1)
	undamageableAnimationName = "invinsible"
	
	setBaseDamage(1)
	setInitialHealth(1.5, 1.5)
	setInitialStats(1, 1, 2.5, 2.5)
	
	._ready()

func turn(skipTurnBehaviour = false):
	.turn()    
	self.damageable = turnBehaviour.getDamageable() || GameData.player.canAlwaysHurtReapers
