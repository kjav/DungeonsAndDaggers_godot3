extends TouchScreenButton

export(String) var text setget setText, getText
export(PackedScene) var scene setget setScene, getScene

func _ready():
	get_node("MenuButton/MenuButtonLabel").set("text", text)

func setText(value):
	text = value
	if is_inside_tree() and get_tree().is_editor_hint():
		get_node("MenuButton/MenuButtonLabel").set("text", text)

func getText():
	return text

func setScene(value):
	scene = value

func getScene():
	return scene

func _pressed():
	if scene:
		get_tree().change_scene(scene.get_path())
