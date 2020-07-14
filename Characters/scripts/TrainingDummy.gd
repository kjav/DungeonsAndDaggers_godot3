extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _init():
	self.character_name = 'Training Dummy'
	
	hasOnlyRightAnimations = true
	walkAnimationUsesStand = true

func _ready():
	turnBehaviour = Turn.Wait.new(self)
	processBehaviour = Process.Direct.new()
	fixedMaxHealth = true
	
	setBaseDamage(0, 0)
	setInitialHealth(4.5, 4.5)
	setInitialStats(1, 1, 1, 1, 0)
	
	._ready()
