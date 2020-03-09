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
		setTexture(get_node("Primary Icon"), get_node("Primary Background"), get_node("Primary Offhand"), weapon)
	elif slot == Enums.WEAPONSLOT.SECONDARY:
		secondaryWeapon = weapon
		setTexture(get_node("Secondary Icon"), get_node("Secondary Background"), get_node("Secondary Offhand"), weapon)
	
	updateAmmo(slot, weapon.ammo)

func setTexture(icon, background, offhand, weapon):
		icon.set_texture(weapon.iconTexture)
		background.set_texture(GameData.getBackgroundForRarity(weapon.rarity))
		offhand.visible = weapon.isOffhand

func SetCurrentWeapon(slot):
	get_node("Primary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.SECONDARY
	get_node("Primary Inactive Button").visible = not slot == Enums.WEAPONSLOT.PRIMARY && (primaryWeapon != null && primaryWeapon.equiptable)
	get_node("Secondary Inactive Button").visible = not slot == Enums.WEAPONSLOT.SECONDARY && (secondaryWeapon != null && secondaryWeapon.equiptable)