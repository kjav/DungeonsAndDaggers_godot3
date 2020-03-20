extends Node2D

var inventoryOpen
var settingsOpen
var inc = 40

const Heart = preload("res://Hud/Heart.tscn")

const KeyBase = preload("res://Items/scripts/keys/KeyBase.gd")

func _init():
	GameData.hud = self

func _ready():
	inventoryOpen = false
	settingsOpen = false
	PlayerHealthChanged(GameData.player.stats.health.value, GameData.player.stats.health.maximum)
	GameData.player.connect("healthChanged", self, "PlayerStatChanged")
	GameData.player.connect("statsChanged", self, "PlayerStatChanged")
	GameData.player.connect("playerHealed", self, "_on_Player_healthRaised")
	GameData.player.connect("weaponChanged", self, "PlayerWeaponChanged")
	GameData.player.connect("itemPickedUp", self, "_on_Player_itemPickedUp")
	GameData.player.connect("playerMove", self, "CheckFloor")
	PlayerWeaponChanged(Enums.WEAPONSLOT.PRIMARY, GameData.player.primaryWeapon)
	PlayerWeaponChanged(Enums.WEAPONSLOT.SECONDARY, GameData.player.secondaryWeapon)
	PlayerWeaponChanged(Enums.WEAPONSLOT.TERTIARY, GameData.player.tertiaryWeapon)
	SetCurrentWeapon(Enums.WEAPONSLOT.PRIMARY)

func CheckFloor(pos):
	if GameData.itemAtPos(pos) or GameData.stairsAtPos(pos):
		get_node("ContextualMenu").position = (pos + Vector2(0.5, 0.5)) * GameData.TileSize
		get_node("ContextualMenu").activate(pos)
		get_node("ContextualMenu").show()
	else:
		get_node("ContextualMenu").hide()

func SetCurrentWeapon(currentSlot):
	get_node("HudCanvasLayer/WeaponSlots").SetCurrentWeapon(currentSlot)

func PlayerWeaponChanged(slot, weapon):
	get_node("HudCanvasLayer/WeaponSlots").setIconTexture(slot, weapon)

func PlayerHealthChanged(health, maxHealth):
	for child in get_node("HudCanvasLayer/HealthBar").get_children():
		child.queue_free()
		child.hide()
	for i in range(1, maxHealth + 1):
		var heart = Heart.instance()
		heart.set_position(Vector2(inc * i, 0))
		get_node("HudCanvasLayer/HealthBar").add_child(heart)
		if i <= health:
			heart.setType(heart.Full)
		elif health == i - 0.5:
			heart.setType(heart.Half)
		else:
			heart.setType(heart.Empty)
	
	if health <= 0:
		get_node("HudCanvasLayer/DeathMenu").died()
		get_node("HudCanvasLayer/Turn Timer").hide()

func _on_Environment_unlocked(unlockGuid, environmentObjectsName):
	get_node("HudCanvasLayer/Keys").KeyAmountChanged()
	get_node("HudCanvasLayer/EventMessageHolder")._on_Environment_unlocked(environmentObjectsName);

func PlayerStatChanged(stat, direction, value):	
	if stat == "health" or stat == "maxhealth":
		PlayerHealthChanged(GameData.player.stats.health.value, GameData.player.stats.health.maximum)

func SetVisibilityOfTeleportWarning(visibility):
	get_node("HudCanvasLayer/Teleport Warning").visible = visibility

func _on_Player_itemPickedUp(item):
	if item is KeyBase:
		get_node("HudCanvasLayer/Keys").AddKey(item)
	
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_itemPickedUp(item);

func _on_Player_weaponChanged(slot, weapon):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_weaponChanged(slot, weapon);

func _on_Player_playerAttack(character, amount):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_playerAttack(character, amount);

func _on_Enemy_attack(character, amount):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Enemy_attack(character, amount);

func _on_Player_healthRaised(value):
	get_node("HudCanvasLayer/EventMessageHolder")._on_Player_healthRaised(value);

func _on_GameClickableRegion_clicked_inside(event):
	GameData.player.gameClickableRegionClicked(event)

func addEventMessage(message):
	get_node("HudCanvasLayer/EventMessageHolder").addMessage(message);

func show_upgrade_menu():
	get_tree().paused = true
	get_node("HudCanvasLayer/UpgradeMenu").show()