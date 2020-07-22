tool
extends Light2D

var noise

func _ready():
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8

var time = 0
func _process(delta):
	time += delta * 20 * (1 + noise.get_noise_2d(time, 1000.0))
	energy = (noise.get_noise_2d(time, 1.0) + 1) * 3
