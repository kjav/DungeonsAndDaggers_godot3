extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/pellet.jpg")
var moveTo
var attackedLastTurn

func _init():
	self.character_name = 'Novice Mage'
	item_distribution = Constants.Distribution.new([
		{"p": 0.07, "value": Constants.UncommonFoodsDistribution.pick()[0].value}, 
		{"p": 0.06, "value": Constants.CommonFoodsDistribution.pick()[0].value}, 
		{"p": 0.05, "value": Constants.CommonSpellsDistribution.pick()[0].value },
		{"p": 0.05, "value": Constants.UncommonSpellsDistribution.pick()[0].value },
		{"p": 0.2, "value": Constants.SpellClasses.MissileSpell }
	])

func _ready():
	moveTo = Turn.MoveTo.new(self)
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	turnBehaviour.setWaitEvery(2)
	attackedLastTurn = false
	fixedMaxHealth = true
	
	setBaseDamage(0.5, 0)
	setInitialHealth(1.5, 1.5)
	setInitialStats(1.5, 1.5, 0.5, 0.5)
	
	._ready()


func turn(skipTurnBehaviour = false):
	if stunnedDuration <= 0 && alive() && GameData.player.alive() && GameData.player.invisibilityTurnsRemaining <= 0 && pathFindingWithinBounds(moveTo.getPathFindingDistance(original_pos)):
		if !attackedLastTurn:
			attackedLastTurn = true
			
			castMissile()
		else:
			attackedLastTurn = false
		
		.turn(true)
	else:
		attackedLastTurn = false
		.turn()

func pathFindingWithinBounds(distance):
	return distance != -1 && distance <= 4

func castMissile():
	GameData.hud.addEventMessage(character_name + " cast a missile at you!")
	
	var new_missile = missile.instance()
	#Audio.playSoundEffect("Missile_Flying")
	self.get_parent().add_child(new_missile)
	
	var damage = base_damage
	
	if randi()%100 < 66 * pow(0.75, GameData.currentDifficultyUndeadCrypt):
		damage = 0
	
	new_missile.init(
		self,
		GameData.player,
		missile_texture,
		get_position() + Vector2(GameData.TileSize/2, GameData.TileSize/2),
		25,
		damage,
		"Missile_Hit",
		Vector2(0.2, 0.2),
		true,
		false
	)
