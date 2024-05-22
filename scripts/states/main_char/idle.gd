extends State

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	player.play_anim("Idle")
	player.velocity = Vector3.ZERO

func update(delta: float) -> void:
	if recieving_moving_input():
		state_machine.transition_to("moving")
	pass

func exit() -> void:
	pass
