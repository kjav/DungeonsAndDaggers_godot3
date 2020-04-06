extends TextureButton

var clickable = true

export var upgrade = "" setget setUpgrade, getUpgrade
var shouldDelete = false

func setUpgrade(new_upgrade):
	if new_upgrade is String:
		upgrade = { "value": Constants.UpgradeClasses.DefenceUpgrade, "onetime": false }
	
	upgrade = new_upgrade.value.new()
	shouldDelete = new_upgrade.onetime
	
	get_node("Title").text = upgrade.title
	get_node("Description").text = upgrade.description
	get_node("Icon").texture = upgrade.texture

func getUpgrade():
	return upgrade

func removeUpgradeFromPool():
	if shouldDelete:
		for i in range(0, Constants.AllUpgrades.size()):
			if upgrade is Constants.AllUpgrades[i].value:
				Constants.AllUpgrades.remove(i)
				Constants.UpgradesDistribution = Constants.DistributionOfEquals.new(Constants.AllUpgrades)
				return

func _pressed():
	if clickable:
		upgrade.onUse()
		removeUpgradeFromPool()
		get_parent().close()
