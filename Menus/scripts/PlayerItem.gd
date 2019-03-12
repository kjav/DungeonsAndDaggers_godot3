tool
extends Node2D

export(Texture) var playerTexture setget setPlayerTexture, getPlayerTexture
export(String) var playerName setget setPlayerName, getPlayerName
export(int) var playerStrength setget setPlayerStrength, getPlayerStrength
export(int) var playerDefence setget setPlayerDefence, getPlayerDefence
export(int) var playerHitpoints setget setPlayerHitpoints, getPlayerHitpoints
export(int) var playerSpeed setget setPlayerSpeed, getPlayerSpeed
export(String) var playerDescription setget setPlayerDescription, getPlayerDescription
export(bool) var playerEditable setget setPlayerEditable, getPlayerEditable

func setPlayerTexture(t):
	if typeof(t) == TYPE_OBJECT:
		get_node("PlayerImage").set_texture(t)
		playerTexture = t

func getPlayerTexture():
	return playerTexture

func setPlayerName(n):
	if typeof(n) == TYPE_STRING:
		get_node("PlayerNameLabel").text = n
		playerName = n

func getPlayerName():
	return playerName

func setPlayerStrength(value):
	if typeof(value) == TYPE_INT:
		get_node("StrengthRange").progress = value
		playerStrength = get_node("StrengthRange").progress

func getPlayerStrength():
	return playerStrength

func setPlayerDefence(value):
	if typeof(value) == TYPE_INT:
		get_node("DefenceRange").progress = value
		playerDefence = get_node("DefenceRange").progress

func getPlayerDefence():
	return playerDefence

func setPlayerHitpoints(value):
	if typeof(value) == TYPE_INT:
		get_node("HitpointsRange").progress = value
		playerHitpoints = get_node("HitpointsRange").progress

func getPlayerHitpoints():
	return playerHitpoints

func setPlayerSpeed(value):
	if typeof(value) == TYPE_INT:
		get_node("SpeedRange").progress = value
		playerSpeed = get_node("SpeedRange").progress

func getPlayerSpeed():
	return playerSpeed

func setPlayerDescription(value):
	if typeof(value) == TYPE_STRING:
		get_node("PlayerDescriptionLabel").text = value
		playerDescription = value

func getPlayerDescription():
	return playerDescription

func setPlayerEditable(value):
	if typeof(value) == TYPE_BOOL:
		playerEditable = value
		get_node("StrengthRange").editable = value
		get_node("DefenceRange").editable = value
		get_node("HitpointsRange").editable = value
		get_node("SpeedRange").editable = value

func getPlayerEditable():
	return playerEditable
