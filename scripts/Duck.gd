class_name Duck extends Node3D

@onready var anim_player: AnimationPlayer = $Sketchfab_Scene/AnimationPlayer
@onready var egg: Egg = $egg

var move: bool = false
var timer: float = 0
var time_to_disappear: float = 20

func _physics_process(delta: float) -> void:
	if move:
		position += -transform.basis.z * delta * 2
		timer += delta
		if (timer > time_to_disappear):
			queue_free()
	pass

func move_forward():
	anim_player.play("walkcycle_1")
	move = true

func _on_damage_reciever_area_entered(area: Area3D) -> void:
	anim_player.play("death")
	await anim_player.animation_finished
	
	egg.show()
	egg.move_forward()
	pass
