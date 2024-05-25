class_name Hare extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var coll: CollisionShape3D = $damage_reciever/CollisionShape3D
@onready var duck: Duck = $duck

var move: bool = false
var timer: float = 0
var time_to_disappear: float = 10

func _ready() -> void:
	#coll.disabled = true
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

func enable_coll():
	coll.disabled = false

func _on_damage_reciever_area_entered(area: Area3D) -> void:
	anim_player.play("death")
	await anim_player.animation_finished
	
	duck.show()
	duck.move_forward()
	pass
