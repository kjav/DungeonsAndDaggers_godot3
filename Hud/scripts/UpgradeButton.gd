extends TextureButton

var clickable = true

export var upgrade = Constants.UpgradeClasses.DefenceUpgrade3 setget setUpgrade, getUpgrade

func setUpgrade(new_upgrade):
	get_node("Title").text = new_upgrade.title
	get_node("Description").text = new_upgrade.description
	get_node("Icon").texture = new_upgrade.texture
	upgrade = new_upgrade

func getUpgrade():
	return upgrade

func _pressed():
	if clickable:
		upgrade.onUse()
		get_parent().close()