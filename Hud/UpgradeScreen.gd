extends Control

export(Curve) var RollCurve
export(int) var animation_length = 2.7

var buttons = []
var time = 0
var spinning = false
var speeds = []
var juggle = [0, 0, 0]

signal timeout

func close():
	get_tree().paused = false
	get_node("ReRoll").disabled = false
	get_node("sparkle").hide()
	speeds = []
	buttons = []
	time = 0
	get_node("ReRoll/Trophy").grayscale = false
	hide()

func get_upgrade():
	return Constants.UpgradesDistribution.pick()[0]

func show():
	for node in range(1,4):
		var button = get_node("UpgradeButton" + str(node))
		button.upgrade = get_upgrade()
		buttons.append(button)
		speeds.append(randf() * 2000 + 2000)
	for node in range(4, 7):
		var button = get_node("UpgradeButton" + str(node))
		button.upgrade = get_upgrade()
		buttons.append(button)

	.show()

func _process(delta):
	time += delta
	if spinning:
		for i in range(0, 3):
			var speed = Vector2(
				speeds[i] * delta * RollCurve.interpolate_baked(time / animation_length),
				0
			)
			buttons[i].rect_position += speed
			buttons[i+3].rect_position += speed
			
			var juggle_index = i + 3 * juggle[i]
			if buttons[juggle_index].rect_position.x > 1106:
				juggle[i] = int(1 - juggle[i])
				if time <= animation_length:
					buttons[juggle_index].rect_position.x -= 2000
					buttons[juggle_index].upgrade = get_upgrade()
				else:
					var new_juggle_index = i + 3 * juggle[i]
					buttons[new_juggle_index].rect_position.x = 106
					buttons[juggle_index].rect_position.x = -894
					speeds[i] = 0
					if speeds[0] == 0 and speeds[1] == 0 and speeds[2] == 0:
						# Finished animation
						for button in buttons:
							button.clickable = true
							get_node("sparkle").emitting = true
							get_node("sparkle").restart()
							get_node("sparkle").show()
							spinning = false

func reroll(currency, amount):
	if currency == "reroll":
		print("After loading")
		get_node("ReRoll/Loading").hide()
		get_node("ReRoll/Trophy").show()
		spinning = true
		time = 0
		for button in buttons:
			button.clickable = false

		get_node("ReRoll").disabled = true
		get_node("ReRoll/Trophy").grayscale = true