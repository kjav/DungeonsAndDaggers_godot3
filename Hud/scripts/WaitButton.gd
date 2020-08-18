extends TextureButton

var pressed_time = OS.get_ticks_msec()

func _ready():
	self.visible = !GameData.currentGameModeUsesTimer()

func _pressed():
	if !isDisabled():
		GameData.player.moveDirection(Enums.DIRECTION.NONE)
		GameData.player.MoveCharacters()
		pressed_time = OS.get_ticks_msec()

func _process(delta):
	get_node("Overlay").visible = isDisabled()

func isDisabled():
	return OS.get_ticks_msec() - pressed_time < 100
