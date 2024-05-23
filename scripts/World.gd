class_name World extends Node3D

@onready var main_char: MainChar = $MainChar

func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "upd_trg_pos", main_char.global_position)
