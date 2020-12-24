extends Node2D

var target = null
var noise
var time = 0
var light = null

var speed = 100
var maxSpeed = 600
var minSpeed = 0
var steer_force = 80.0
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO


func _ready():
	target = get_node("../Player/Skeleton2D/Orb Position")
	light = get_node("Light2D")
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
	rotation += rand_range(-0.09, 0.09)
	velocity = transform.x * speed

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.global_position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func _process(delta):
	speed = min(maxSpeed, position.distance_to(target.global_position) * 2 + minSpeed)
	
	light.color.h += delta / 50
	time += delta * 20 * (1 + noise.get_noise_2d(time, 1000.0))
	light.energy = (noise.get_noise_2d(time, .1) + 1.8)
	
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	
	position += velocity * delta
