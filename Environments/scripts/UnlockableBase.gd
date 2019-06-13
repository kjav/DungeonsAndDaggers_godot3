extends "EnvironmentBase.gd"

signal keyUsed(unlockGuid, unlockedObjectsName)

export(bool) var locked setget setLocked, getLocked
var UnlockGuid

func _ready():
	self.get_node("/root/Node2D").connectUnlockableEnvironment(self)

func setLocked(_locked):
	if typeof(_locked) == TYPE_BOOL:
		locked = _locked

		if _locked:
			walkable = Enums.WALKABLE.NONE
		else:
			walkable = Enums.WALKABLE.ALL
		
		if get_node("Locks") != null:
			get_node("Locks").visible = !(!locked)

func setLockedButNotWalkable(_locked):
	if typeof(_locked) == TYPE_BOOL:
		locked = _locked
		if get_node("Locks") != null:
			get_node("Locks").visible = !(!locked)

func keyUnlocked():
	GameData.RemoveKey(UnlockGuid)
	emit_signal("keyUsed", UnlockGuid, environment_name)
	setLocked(false)

func getLocked():
	return locked

func setUnlockGuid(unlockGuid):
	UnlockGuid = unlockGuid
