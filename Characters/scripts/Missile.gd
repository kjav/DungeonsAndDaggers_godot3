
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

func init(_target, _texture, _pos, _speed, _damage, _hitSound):
	set_texture(_texture)
	set_position(_pos)
	
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
		
		if willReachTargetAfterMove(target_pos):
			handleTargetReached()
		else:
			setNextState(target_pos)

func setNextState(target_pos):
	set_rotation((get_position()).angle_to_point(target_pos) + 90)
	set_position(get_position() + (target_pos - get_position()).normalized() * speed)

func handleTargetReached():
	#Audio.playSoundEffect(hitSound, true)
	set_process(false)
	get_node(target).takeDamage(damage)
	get_parent().remove_child(self)
	queue_free()

func willReachTargetAfterMove(target_pos):
	return get_position().distance_squared_to(target_pos) <= speed * speed

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
