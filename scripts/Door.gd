class_name Door extends Node3D

@export var next_room : PackedScene
@onready var interact_area: Area3D = $interact_area
var main_char_is_in_area : bool = false
var ignore_input: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if ignore_input: return
	
	if Input.is_action_just_pressed("interact"):
		for b in interact_area.get_overlapping_bodies():
			if b is MainChar:
				#print("interact door")
				ignore_input = true
				G.transition_to(get_parent(), next_room)
	pass

func _on_interact_area_body_entered(body: Node3D) -> void:
	if body is MainChar:
		main_char_is_in_area = true
	pass

func _on_interact_area_body_exited(body: Node3D) -> void:
	if body is MainChar:
		main_char_is_in_area = true
	pass
