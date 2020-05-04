extends Node2D


func _ready():
	get_node("FloorItems").setupConnection()
	GameData.effectsNode = get_node("Effects")
	
	GameData.addCurrentStatusEffects()

func connectEnemy(enemy):
	enemy.connect("attack", get_node("HudNode"), "_on_Enemy_attack")

func connectEnvironmentToPathfinding(environmentObject):
	environmentObject.connect("blockStateChanged", get_node("OgresDomain"), "_on_Environment_blockStateChanged")
	
func connectUnlockableEnvironment(environmentObject):
	environmentObject.connect("keyUsed", get_node("HudNode"), "_on_Environment_unlocked")
