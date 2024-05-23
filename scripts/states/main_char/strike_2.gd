class_name Strike_2 extends State

var anim_player : AnimationPlayer
var trans_to_strike_3 : bool = false

func enter(_msg := {}) -> void:
	((player.weapon as Area3D).find_child("CollisionShape3D") as CollisionShape3D).disabled = false
	
	anim_player = player.anim_player
	anim_player.play("strike-2")
	await anim_player.animation_finished
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
	((player.weapon as Area3D).find_child("CollisionShape3D") as CollisionShape3D).disabled = true
	pass
