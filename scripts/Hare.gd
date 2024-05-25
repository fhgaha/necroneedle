class_name Hare extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var move: bool = false
var timer: float = 0
var time_to_disappear: float = 10

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if move:
		position += -transform.basis.z * delta * 5
		timer += delta
		if (timer > time_to_disappear):
			queue_free()
	pass

func move_forward():
	anim_player.play("run")
	move = true
