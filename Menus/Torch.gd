tool
extends Node2D

export var time_offset = 0.0 setget set_time_offset

func set_time_offset(to):
	time_offset = to
	get_node("Flame").material.set_shader_param("time_offset", to)
