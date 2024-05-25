class_name Idle extends State

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter(_msg := {}) -> void:
	player.play_anim("Idle")
	player.velocity = Vector3.ZERO

func update(delta: float) -> void:
	if Input.is_action_just_pressed("strike"):
		state_machine.transition_to("strike_1")
		return
	
	if recieving_moving_input():
		state_machine.transition_to("moving")
	pass

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= gravity * _delta
	player.move_and_slide()

func exit() -> void:
	pass
