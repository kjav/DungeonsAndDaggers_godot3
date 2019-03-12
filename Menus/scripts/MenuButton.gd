tool
extends TextureButton

export(PackedScene) var scene setget setScene, getScene

func setScene(value):
	scene = value

func getScene():
	return scene

func _on_pressed():
	get_tree().change_scene(scene.get_path())