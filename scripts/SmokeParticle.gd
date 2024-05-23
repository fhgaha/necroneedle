class_name SmokeParticle extends Node3D

@onready var gpu_prtcl: GPUParticles3D = $GPUParticles3D

func _ready() -> void:
	gpu_prtcl.emitting = false

func run_once_() -> void:
	await run_once(0.3)

func run_once(seconds : float) -> void:
	gpu_prtcl.restart()
	#gpu_prtcl.emitting = true
	#await get_tree().create_timer(seconds).timeout
	#gpu_prtcl.emitting = false
	gpu_prtcl.one_shot = true
	gpu_prtcl.emitting = true
	await gpu_prtcl.finished
	queue_free()
