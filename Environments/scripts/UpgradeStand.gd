extends "EnvironmentBase.gd"

var current_time = 0.0
var shield_time = 0.0
var frametime = 0.1

func _ready():
	walkable = true
	set_process(true)

func _process(delta):
	var shield = get_node("Shield")
	shield.offset.y = sin(shield_time * 1.5) * 2.5
	current_time += delta
	shield_time += delta
	# If the frame time has been exceeded
	if current_time > frametime:
		# Advance the frame
		var aura = get_node("Aura")
		# Get total number of frames in rectangular tileset
		var total_frames = aura.get_vframes() * aura.get_hframes()
		# Add on however frames we have advanced
		aura.set_frame(fmod(aura.get_frame() + floor(current_time / frametime),total_frames))
		# Take those frames off of the current time
		current_time = current_time - floor(current_time / frametime) * frametime

func onWalkedInto(character):
	if character == GameData.player:
		print("Should now show upgrade menu!")
	return true
