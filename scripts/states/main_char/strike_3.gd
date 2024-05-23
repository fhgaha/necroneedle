class_name Strike_3 extends State

var anim_player : AnimationPlayer

func enter(_msg := {}) -> void:
	#((player.weapon as Area3D).find_child("CollisionShape3D") as CollisionShape3D).disabled = false
	
	anim_player = player.anim_player
	anim_player.play("strike-3")
	await anim_player.animation_finished
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
	#((player.weapon as Area3D).find_child("CollisionShape3D") as CollisionShape3D).disabled = true
	pass
