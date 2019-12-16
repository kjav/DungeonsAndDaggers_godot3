extends "../Item.gd"

var UnlockGuid
var ValidFloorNumber

func setUnlockGuid(unlockGuid):
	UnlockGuid = unlockGuid

func setValidFloorNumber(validFloorNumber):
	ValidFloorNumber = validFloorNumber

func pickup():
	GameData.addKey(self)
	.pickup()

#in the future will have to check for valid floor too
func IsValidKey(unlockGuid):
	return UnlockGuid == unlockGuid
