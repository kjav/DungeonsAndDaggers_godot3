extends Node2D

func _ready():
	get_node("Primary Inactive Overlay").representedSlot = Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Inactive Overlay").representedSlot = Enums.WEAPONSLOT.SECONDARY

func setIconTexture(slot, texture):
    if slot == Enums.WEAPONSLOT.PRIMARY:
	    get_node("Primary Icon").set_texture(texture)
    elif slot == Enums.WEAPONSLOT.SECONDARY:
	    get_node("Secondary Icon").set_texture(texture)

func SetCurrentWeapon(slot):
	get_node("Primary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.SECONDARY