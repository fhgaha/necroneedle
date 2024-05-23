class_name Zombie1Attacking extends Zombie1State

func enter(_msg := {}) -> void:
	print("z entered attacking")
	
	var anim_player: AnimationPlayer = player.anim_player
	player.play_anim("attack")
	await anim_player.animation_finished
	#await get_tree().process_frame
	state_machine.transition_to("idle")
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
