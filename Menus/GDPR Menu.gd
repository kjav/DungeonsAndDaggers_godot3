extends Node2D

var consent_file_path = "user://gdpr_consent.persist"

func _ready():
	pass
	# Read consent from file
	#var file = File.new()
	#var consent_file_exists = file.file_exists(consent_file_path)
	
	#if consent_file_exists:
	#	file.open(consent_file_path, File.READ)
	#	var consent = parse_json(file.get_line())
	#	file.close()
	#	Ad.set_personalised(consent)
	#else:
	#	show()

func create_personalised(personalised):
	Ad.set_personalised(personalised)
	hide()
	# Persist consent to file
	var file = File.new()
	file.open(consent_file_path, File.WRITE)
	file.store_line(to_json(personalised))
	file.close()
	

func confirm():
	create_personalised(true)

func reject():
	create_personalised(false)
