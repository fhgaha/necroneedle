class_name Egg extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var needle_anim: AnimationPlayer = $needle_breaking/AnimationPlayer

var move: bool = false
var timer: float = 0
var time_to_disappear: float = 20

func _ready() -> void:
	var a = $needle_breaking
	a.hide()

func _physics_process(delta: float) -> void:
	if move:
		position += -transform.basis.z * delta * 2
		timer += delta
		if (timer > time_to_disappear):
			queue_free()
	pass

func move_forward():
	anim_player.play("roll")
	move = true

func _on_damage_reciever_area_entered(area: Area3D) -> void:
	#play final animation
	print("egg was hit")
	$needle_breaking.show()
	needle_anim.play("default")
	await needle_anim.animation_finished
	$needle_breaking/win_text.show()
	pass
