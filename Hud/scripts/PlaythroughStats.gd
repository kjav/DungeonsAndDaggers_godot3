extends Node2D

const monsterText = "Monsters Defeated: "
const levelText = "Level Reached: "
# const upgradesText = "Upgrades Learnt: "
# const chestsText = "Chests Looted: "
# const slainText = "Slain By A "
const outOfText = " / "

func SetLabels(kills, level):
	get_node("Monsters").text = monsterText + str(kills) + outOfText + "18"
	get_node("Level").text = levelText + str(level) + outOfText + "4"
	# get_node("Upgrades").text = upgradesText + str(upgrades) + outOfText + "5"
	# get_node("Chests").text = chestsText + str(chests) + outOfText + "2"
	# get_node("Slain").text = slainText + slainBy