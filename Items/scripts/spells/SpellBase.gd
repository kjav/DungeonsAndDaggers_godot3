extends "../Item.gd"

func _init():
	._init()
	typeNameForMessage = " Spell"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addSpells([self])
	.pickup()

func onUse():
	GameData.spells.remove(GameData.spells.find(self))
	.onUse()

	if !GameData.player.firstSpellTurnFree || !GameData.player.isFirstSpell:
		GameData.player.forceTurnEnd()

	GameData.player.isFirstSpell = false

func onWalkedOut():
	pass
