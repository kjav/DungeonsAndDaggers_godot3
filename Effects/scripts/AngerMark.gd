extends AnimatedSprite

const timeToLive = 0.5
const distance = 20
var Rotation

func setRotation(rotation):
	Rotation = rotation
	self.rotation = rotation

func _ready():
	# Initialization here
	var timer = Timer.new()
	timer.set_wait_time(timeToLive)
	timer.connect("timeout", self, "Timeout") 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()

func Timeout():
	self.queue_free()
	self.hide()

func _process(delta):
	self.position -= Vector2(distance * (delta / timeToLive), 0).rotated(Rotation)