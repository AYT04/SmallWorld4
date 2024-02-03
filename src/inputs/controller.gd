extends Node
class_name ControledByPlayer
# Let the user control it's parent with the keyboard

@export var speed: int = 200
@export var gravity: int = 10
@export var active: bool = true # Movement can be disabled when inventory is openned for example

var parent: CharacterBody3D
var velocity = Vector2(0, 0)

func _ready():
	parent = get_parent()
	assert(parent is CharacterBody3D, "controller must have a CharacterBody3D as parent to control")

func _process(delta):
	if active:
		update_position(delta)

func _unhandled_key_input(event):
	if active:
		compute_strength(event)

# Keep track of the user inputs 
var right_strength = 0.0
var left_strength = 0.0
var up_strength = 0.0
var down_strength = 0.0
func compute_strength(event):
	if event.is_action_pressed("right"):
		right_strength = event.get_action_strength("right")
	elif event.is_action_released("right"):
		right_strength = 0.0
	
	if event.is_action_pressed("left"):
		left_strength = event.get_action_strength("left")
	elif event.is_action_released("left"):
		left_strength = 0.0
	
	if event.is_action_pressed("down"):
		down_strength = event.get_action_strength("down")
	elif event.is_action_released("down"):
		down_strength = 0.0
	
	if event.is_action_pressed("up"):
		up_strength = event.get_action_strength("up")
	elif event.is_action_released("up"):
		up_strength = 0.0
 
# Uses the results of compute_strength to more the parent
func update_position(delta):
	var userControl = Vector2.ZERO
	userControl.x = right_strength - left_strength
	userControl.y = down_strength - up_strength

	velocity = velocity.lerp(userControl.normalized() * speed * delta, 0.1)
	parent.velocity = Vector3(velocity.x, -gravity, velocity.y)
	parent.move_and_slide()

	#if velocity.length() >= 1:
	var target_angle = atan2(velocity.x, velocity.y)
	var buff = parent.get_rotation()
	buff.y = lerp_angle(buff.y, target_angle, 0.1)
	parent.set_rotation(buff)
