extends Node

func playSoundEffect(name, unique = false):
	return play(name, false)

func playHit():
	randomize()
	var which = randi()%3
	if (which == 0):
		playSoundEffect("Hit_1", false)
	elif (which == 1):
		playSoundEffect("Hit_2", false)
	else:
		playSoundEffect("Hit_3", false)

func stopSound(voiceId):
	stop(voiceId)

func playWalk():
	randomize()
	var which = randi()%3
	if (which == 0):
		Audio.play("Walk_1", false)
	elif (which == 1):
		Audio.play("Walk_2", false)
	else:
		Audio.play("Walk_3", false)
