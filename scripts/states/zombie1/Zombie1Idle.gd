class_name Zombie1Idle extends Zombie1State

func enter(_msg := {}) -> void:
	print("z entered idle")
	player.play_anim("idle")
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if player.trg_pos != Vector3(-100, -100, -100):
		state_machine.transition_to("moving")
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
