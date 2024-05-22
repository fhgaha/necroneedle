extends State

var anim_player : AnimationPlayer
#var offset : Vector3 = Vector3(0, 0, 1.3)

func enter(_msg := {}) -> void:
	anim_player = player.anim_player
	#player.root.position -= offset
	anim_player.play("strike-3")
	await anim_player.animation_finished
	#stupid shit to position doesnt change instantly
	await get_tree().process_frame
	state_machine.transition_to("idle")
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	#player.root.position += offset
	pass
