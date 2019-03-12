extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here2
	pass

func _gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		self.get_parent().right()
