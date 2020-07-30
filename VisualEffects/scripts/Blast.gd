extends AnimatedSprite

func _ready():
	# Initialization here
	var timer = Timer.new()
	timer.set_wait_time(2)
	timer.connect("timeout",self,"Timeout") 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()

func Timeout():
	self.queue_free()
	self.hide()
