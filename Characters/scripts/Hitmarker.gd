extends Node2D

var amount setget setAmount, getAmount
var n = 0 setget setN, getN
var blockHitmarket =  preload("res://assets/block_hitmarker.png")
var hitmarkerScene

signal death(n)

func setAmount(newAmount):
	if typeof(newAmount) == TYPE_INT:
		amount = newAmount
		get_node("Container/Amount").set_text(str(amount))
	elif typeof(newAmount) == TYPE_REAL:
		amount = round(newAmount * 2) / 2
		get_node("Container/Amount").set_text(str(amount))
	else:
		print("Error: hitsplat amount not numeric")

func setBlockedHitmarker():
	hitmarkerScene.texture = blockHitmarket
	hitmarkerScene.set_scale(Vector2(0.6, 0.6))
	hitmarkerScene.rect_position += Vector2(40, 30)

func getAmount():
	return amount

func get_offset(n):
	# Place the hit splat on a hexagonal grid - see "Rings", "Spiral rings" at:
	# https://www.redblobgames.com/grids/hexagons
	if n == 0:
		return Vector2(0, 0)
	else:
		var ring = floor(-1.0/2.0 + sqrt(9.0 + 12.0 * (n - 1.0)) / 6.0) + 1
		var index = n - ring * (2 + (ring - 1) * 5) / 2.0
		
		var radius = ring
		var edge = radius
		var traversal = Vector2(-1.0/2.0, sqrt(3.0)/2.0) * 512.0
		
		# Move from centre to ring
		# Set initial position
		var position = Vector2(1, 0) * radius * 512.0
		while index > 0:
			# Traverse each edge <radius> times and then rotate
			edge -= 1
			position += traversal
			if edge == 0:
				# Rotate traversal by 60 degrees
				traversal = traversal.rotated(PI * -60/180)
				edge = radius
			index -= 1
		return position

func setN(newN):
	if typeof(newN) == TYPE_INT:
		n = newN
		get_node("Container").set_position(get_offset(n))
	else:
		print("Error: hitsplat number not an integer")

func getN():
	return n

func _ready():
	# Initialization here
	hitmarkerScene = get_node("Container/Hitmarker")
	var timer = Timer.new()
	timer.set_wait_time(1)
	timer.connect("timeout",self,"Timeout") 
	timer.set_one_shot(true)
	add_child(timer)
	timer.start()

func Timeout():
	emit_signal("death", n)
	self.queue_free()
	self.hide()

