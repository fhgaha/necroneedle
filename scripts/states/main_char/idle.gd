extends State

# Upon entering the state, we set the Player node's velocity to zero.
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

func exit() -> void:
	pass
