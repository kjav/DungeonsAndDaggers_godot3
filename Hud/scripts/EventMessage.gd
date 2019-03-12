extends Node2D

signal timeout(node)

func _ready():
	get_node("Timer").connect("timeout", self, "_on_Timer_timeout");

func set_text(text):
	get_node("Output").set_text(text);

func get_height():
	return get_node("Output").get_size().y * get_node("Output").get_scale().y;

func _on_Timer_timeout(): 
	get_node("..")._on_Timer_timeout(self);

func remove():
	hide();
	queue_free(); 

