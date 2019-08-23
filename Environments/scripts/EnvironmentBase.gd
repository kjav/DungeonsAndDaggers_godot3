extends AnimatedSprite

signal blockStateChanged(environmentObject, blockedState)

var walkable
var pos
var environment_name
var blockFromPathFindingWhenReady
var initialReadyCall = true

func _ready():
	self.get_node("/root/Node2D").connectEnvironmentToPathfinding(self)
	pos = get_position()

	#Any calls made to setLocked before the environment is ready wont have correctly emited the signal and need rerunning
	if blockFromPathFindingWhenReady and initialReadyCall:
		emitBlockedStateChangeSignal(true);
	
	initialReadyCall = false

func setPos(_pos):
	set_position(_pos)
	pos = _pos

func onWalkedInto(character):
	pass

func emitBlockedStateChangeSignal(state):
	emit_signal("blockStateChanged", self, state)

func remove():
	GameData.RemoveEnvironment(self)
	hide()
	queue_free()
