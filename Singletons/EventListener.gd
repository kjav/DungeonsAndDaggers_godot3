extends Node

func _ready():
	pass

var listeners = {}

func listen(event, callback):
	if not listeners.has(event):
		listeners[event] = []
	listeners[event].append(callback)

func ignore(event, callback):
	if listeners.has(event):
		var i = listeners[event].find(callback)
		listeners[event].remove(i)

func raise(event, args):
	if listeners.has(event):
		for callback in listeners[event]:
			callback.call_func(args)
