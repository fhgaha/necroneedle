extends State

var anim_player : AnimationPlayer
#var offset : Vector3 = Vector3(0, 0, 1.3)
var trans_to_strike_3 : bool = false

func enter(_msg := {}) -> void:
	anim_player = player.anim_player
	#player.root.position -= offset
	anim_player.play("strike-2")
	await anim_player.animation_finished
	#stupid shit to position doesnt change instantly
	await get_tree().process_frame
	if trans_to_strike_3:
		trans_to_strike_3 = false
		state_machine.transition_to("strike_3")
		return
	state_machine.transition_to("idle")
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("strike"):
		trans_to_strike_3 = true
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	#player.root.position += offset
	pass
