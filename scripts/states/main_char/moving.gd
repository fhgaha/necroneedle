extends State

@export var SPEED : float = 5.0 
const JUMP_VELOCITY = 4.5
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var cam: Camera3D

func enter(_msg := {}) -> void:
	player.play_anim("Running")
	pass

func update(delta: float) -> void:
	if not recieving_moving_input():
		state_machine.transition_to("idle")
	pass

func exit() -> void:
	pass

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= gravity * _delta

	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("strike"):
		state_machine.transition_to("strike_1")
		return
	
	move(_delta)

func move(_delta: float):
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction: Vector3 = (player.cam.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
		var to_look_at = -Vector3(direction.x, player.global_position.y, direction.z)
		player.look_at(player.global_position + to_look_at)
	else:
		player.velocity.x = 0
		player.velocity.z = 0

	player.move_and_slide()
	pass
