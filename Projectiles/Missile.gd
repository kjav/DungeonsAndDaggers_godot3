extends Sprite

const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")

export(NodePath) var target setget setTarget, getTarget
export(float) var speed = 25
export(float) var damage = 0
var flyingSound
var caster
var soundID
var hitSound
var inflictDamage
var targetPath
var explodes
var total_time = 0
var delay = 0.05

func _ready():
	if target:
		set_process(true)

func init(_caster, _target, _texture, _pos, _speed, _damage, _hitSound, _scale, _inflictDamage, _explodes):
	set_texture(_texture)
	set_position(_pos)
	set_scale(_scale)

	caster = _caster
	speed = _speed
	damage = _damage
	target = _target
	targetPath = _target.get_path()
	hitSound = _hitSound
	inflictDamage = _inflictDamage
	explodes = _explodes

	var tileDistance = abs(target.get_position().x - get_position().x) + abs(target.get_position().y - get_position().y)

	if (tileDistance / GameData.TileSize) <= 3:
		if inflictDamage:
			damage(target, damage)
		
		if explodes:
			handleExplosion()
		
		inflictDamage = false

func damage(_target, _damage):
	_target.takeDamage(_damage)

	if caster == GameData.player:
		GameData.hud.get_node("HudCanvasLayer/EventMessageHolder")._on_Player_playerAttack(_target, _damage);
	else:
		GameData.hud.get_node("HudCanvasLayer/EventMessageHolder")._on_Enemy_attack(caster, _damage);

func _process(delta):
	total_time += delta
	
	if isFinished():
		showIfVisible()
		
		var half_tile = Vector2(GameData.TileSize / 2, GameData.TileSize / 2)
		var target_pos = get_node(targetPath).get_position() + half_tile
		
		if willReachTargetAfterMove(target_pos, delta):
			handleTargetReached()
		else:
			setNextState(target_pos, delta)

func setNextState(target_pos, delta):
	set_rotation((get_position()).angle_to_point(target_pos) + PI/2)
	# Multiply by delta * 60 to get a frame time normalized to 60fps
	set_position(get_position() + (target_pos - get_position()).normalized() * speed * (delta * 60))

func handleTargetReached():
	#Audio.playSoundEffect(hitSound, true)
	set_process(false)

	if inflictDamage:
		damage(target, damage)
	
	if explodes:
		handleExplosion()

	get_parent().remove_child(self)
	queue_free()

func handleExplosion():
	if inflictDamage:
		var enemiesInArea = GameData.getCharactersWithinAreaAroundCharacter(target, 1)
		damageEnemies(enemiesInArea)
		
	addHeavyImpacts()
	GameData.player.get_node("Camera2D").shake(0.1, 20, 20)

func damageEnemies(enemiesInArea):
	for enemy in enemiesInArea:
		damage(enemy, round(damage) / 2)

func addHeavyImpacts():
	var attackPositions = PositionHelper.getRelativeCoordinatesAroundPoint(1)
	
	attackPositions = convertToAbsolutePosition(attackPositions)
	displayHeavyImpacts(attackPositions)

func displayHeavyImpacts(positions):
	for position in positions:
		var heavyImpactInstance = HeavyImpact.instance()
		
		heavyImpactInstance.position = position
		GameData.effectsNode.add_child(heavyImpactInstance)
		heavyImpactInstance.play()
	

func convertToAbsolutePosition(attackPositions):
	for i in range(attackPositions.size()):
		attackPositions[i] *= GameData.TileSize
		attackPositions[i] += target.position
	
	return attackPositions

func willReachTargetAfterMove(target_pos, delta):
	# Multiply by delta * 60 to get a frame time normalized to 60fps
	return get_position().distance_squared_to(target_pos) <= pow(speed * delta * 60, 2)

func showIfVisible():
	if !is_visible():
		self.show()

func isFinished():
	return total_time > delay

func setTarget(_target):
	target = _target
	set_process(true)

func getTarget():
	return target
