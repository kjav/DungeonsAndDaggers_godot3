extends Node2D

var primaryWeapon
var secondaryWeapon
var tertiaryWeapon

func _ready():
	get_node("Primary Weapon/Primary Inactive Button").representedSlot = Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Weapon/Secondary Inactive Button").representedSlot = Enums.WEAPONSLOT.SECONDARY
	get_node("Tertiary Weapon/Tertiary Inactive Button").representedSlot = Enums.WEAPONSLOT.TERTIARY
	get_node("Tertiary Weapon").visible = GameData.player.thirdWeaponSlot

func updateAmmo(slot, ammo):
	if slot == Enums.WEAPONSLOT.PRIMARY:
		get_node("Primary Weapon/Primary Use Count").text = str(ammo)
		get_node("Primary Weapon/Primary Use Count").visible = ammo != -1
	elif slot == Enums.WEAPONSLOT.SECONDARY:
		get_node("Secondary Weapon/Secondary Use Count").text = str(ammo)
		get_node("Secondary Weapon/Secondary Use Count").visible = ammo != -1
	elif slot == Enums.WEAPONSLOT.TERTIARY:
		get_node("Tertiary Weapon/Tertiary Use Count").text = str(ammo)
		get_node("Tertiary Weapon/Tertiary Use Count").visible = ammo != -1

func setIconTexture(slot, weapon):
	if slot == Enums.WEAPONSLOT.PRIMARY:
		primaryWeapon = weapon
		setTexture(get_node("Primary Weapon/Primary Icon"), get_node("Primary Weapon/Primary Background"), get_node("Primary Weapon/Primary Inactive Button"), weapon)
	elif slot == Enums.WEAPONSLOT.SECONDARY:
		secondaryWeapon = weapon
		setTexture(get_node("Secondary Weapon/Secondary Icon"), get_node("Secondary Weapon/Secondary Background"), get_node("Secondary Weapon/Secondary Inactive Button"), weapon)
	elif slot == Enums.WEAPONSLOT.TERTIARY:
		tertiaryWeapon = weapon
		setTexture(get_node("Tertiary Weapon/Tertiary Icon"), get_node("Tertiary Weapon/Tertiary Background"), get_node("Tertiary Weapon/Tertiary Inactive Button"), weapon)
	
	updateAmmo(slot, weapon.ammo)

func getWeapon(slot):
	if slot == Enums.WEAPONSLOT.PRIMARY:
		return primaryWeapon
	elif slot == Enums.WEAPONSLOT.SECONDARY:
		return secondaryWeapon
	elif slot == Enums.WEAPONSLOT.TERTIARY:
		return tertiaryWeapon

func setTexture(icon, background, inactive, weapon):
		icon.set_texture(weapon.iconTexture)
		background.set_texture(GameData.getBackgroundForRarity(weapon.rarity))
		if weapon.isOffhand:
			inactive.get_node("InactiveLabel").text = "Offhand"
		else:
			inactive.get_node("InactiveLabel").text = "Click To Equip"

func SetCurrentWeapon(slot):
	get_node("Primary Weapon/Primary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.PRIMARY
	get_node("Secondary Weapon/Secondary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.SECONDARY
	get_node("Tertiary Weapon/Tertiary Inactive Overlay").visible = not slot == Enums.WEAPONSLOT.TERTIARY
	
	get_node("Primary Weapon/Primary Inactive Button").visible = not slot == Enums.WEAPONSLOT.PRIMARY && (primaryWeapon != null && primaryWeapon.equiptable)
	get_node("Secondary Weapon/Secondary Inactive Button").visible = not slot == Enums.WEAPONSLOT.SECONDARY && (secondaryWeapon != null && secondaryWeapon.equiptable)
	get_node("Tertiary Weapon/Tertiary Inactive Button").visible = not slot == Enums.WEAPONSLOT.TERTIARY && (tertiaryWeapon != null && tertiaryWeapon.equiptable)

	get_node("Primary Weapon/Not Recommended").visible = slot == Enums.WEAPONSLOT.PRIMARY && (primaryWeapon != null && primaryWeapon.isOffhand)
	get_node("Secondary Weapon/Not Recommended").visible = slot == Enums.WEAPONSLOT.SECONDARY && (secondaryWeapon != null && secondaryWeapon.isOffhand)
	get_node("Tertiary Weapon/Not Recommended").visible = slot == Enums.WEAPONSLOT.TERTIARY && (tertiaryWeapon != null && tertiaryWeapon.isOffhand)
