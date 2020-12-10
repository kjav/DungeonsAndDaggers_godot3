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
	
	setBaseDamage(1)
	setInitialHealth(2.5, 2.5, 2)
	setInitialStats(1, 1, 2.5, 2.5)
	
	get_node("Explosion").setSpeedScale(2.0)
	
	._ready()

func turn(skipTurnBehaviour = false):
	.turn()    
	
	var previouslyDamageable = damageable
	damageable = turnBehaviour.getDamageable() || GameData.player.canAlwaysHurtReapers
	
	if previouslyDamageable and !damageable:
		get_node("Explosion").show()
		get_node("Explosion").explode()
	
	
	if !damageable:
		get_node("ChangingBodyParts").modulate = Color("#262626")
	else:
		get_node("ChangingBodyParts").modulate = Color("#bababa")
