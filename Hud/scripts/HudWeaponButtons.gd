extends Node2D

var primaryWeapon
var secondaryWeapon

func _ready():
	get_node("Primary Inactive Button").representedSlot = Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Inactive Button").representedSlot = Enums.WEAPONSLOT.SECONDARY

func updateAmmo(slot, ammo):
	if slot == Enums.WEAPONSLOT.PRIMARY:
		get_node("Primary Use Count").text = str(ammo)
		get_node("Primary Use Count").visible = ammo != -1
	elif slot == Enums.WEAPONSLOT.SECONDARY:
		get_node("Secondary Use Count").text = str(ammo)
		get_node("Secondary Use Count").visible = ammo != -1

func setIconTexture(slot, weapon):
	if slot == Enums.WEAPONSLOT.PRIMARY:
		primaryWeapon = weapon
		get_node("Primary Icon").set_texture(weapon.texture)
	elif slot == Enums.WEAPONSLOT.SECONDARY:
		secondaryWeapon = weapon
		get_node("Secondary Icon").set_texture(weapon.texture)
	
	updateAmmo(slot, weapon.ammo)

func SetCurrentWeapon(slot):
	get_node("Primary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.SECONDARY
	get_node("Primary Inactive Button").visible = not slot == Enums.WEAPONSLOT.PRIMARY && (primaryWeapon != null && primaryWeapon.equiptable)
	get_node("Secondary Inactive Button").visible = not slot == Enums.WEAPONSLOT.SECONDARY && (secondaryWeapon != null && secondaryWeapon.equiptable)