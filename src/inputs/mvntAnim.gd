extends Node
class_name AnimAccordingToMvnt

# Have the animation play according to its parent's movements

@export var glbmesh: Node3D

var anim: AnimationPlayer
var parent: CharacterBody3D
func _ready():
	assert(glbmesh is Node3D, "You need to provide a glbmesh to animate to contoller")
	anim = glbmesh.get_node("AnimationPlayer")
	assert(anim is AnimationPlayer, "contoller has been provided with an invalid glbmesh, no child named AnimationPlayer")
	parent = get_parent()
	assert(parent is CharacterBody3D, "controller must have a CharacterBody3D as parent to control")

func _process(delta):
	var velocity = parent.get_real_velocity()
	if velocity.length() < 1:
		anim.play("IdleTrack")
	else:
		anim.play("WalkTrack")
