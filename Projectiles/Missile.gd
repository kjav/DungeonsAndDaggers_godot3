
extends Sprite

export(NodePath) var target setget setTarget, getTarget
export(float) var speed = 25
export(float) var damage = 0
var flyingSound
var soundID
var hitSound

var total_time = 0
var delay = 0.05

func _ready():
	if target:
		set_process(true)

func init(_target, _texture, _pos, _speed, _damage, _hitSound, _scale):
	set_texture(_texture)
	set_position(_pos)
	set_scale(_scale)
	
	speed = _speed
	damage = _damage
	target = _target
	hitSound = _hitSound

func _process(delta):
	total_time += delta
	
	if isFinished():
		showIfVisible()
		
		var half_tile = Vector2(GameData.TileSize / 2, GameData.TileSize / 2)
		var target_pos = get_node(target).get_position() + half_tile
		
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
	if damage != 0:
		get_node(target).takeDamage(damage)
	get_parent().remove_child(self)
	queue_free()

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
