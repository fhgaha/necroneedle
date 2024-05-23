class_name Strike_1 extends State

var anim_player : AnimationPlayer
var trans_to_strike_2 : bool = false
var time_passed : float = 0

func enter(_msg := {}) -> void:
	((player.weapon as Area3D).find_child("CollisionShape3D") as CollisionShape3D).disabled = false
	
	anim_player = player.anim_player
	anim_player.play("strike-1")
	await anim_player.animation_finished
	await get_tree().process_frame
	if trans_to_strike_2:
		trans_to_strike_2 = false
		state_machine.transition_to("strike_2")
		return
	state_machine.transition_to("idle")
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if state_machine.state != self: return
	if trans_to_strike_2: return
	
	time_passed += _delta
	
	if (Input.is_action_just_pressed("strike")
	&& (anim_player.current_animation_length - time_passed <= 0.5)):
		trans_to_strike_2 = true
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	time_passed = 0
	((player.weapon as Area3D).find_child("CollisionShape3D") as CollisionShape3D).disabled = true
	pass
