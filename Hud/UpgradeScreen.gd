extends Control

func close():
	get_tree().paused = false
	hide()

func get_upgrade():
	return Constants.UpgradesDistribution.pick()[0].value.new()

func show():
	for node in range(1,4):
		var button = get_node("UpgradeButton" + str(node))
		var upgrade = get_upgrade()
		button.upgrade = upgrade
		
	.show()