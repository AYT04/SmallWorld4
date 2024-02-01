extends Node

# This file is automatically loaded and does sanity checks

func _ready():
	var version_info = Engine.get_version_info()
	assert(version_info.major == 4 and version_info.minor == 2 and version_info.patch == 1, "This project requires Godot version 4.2.1. for consistency reason")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
