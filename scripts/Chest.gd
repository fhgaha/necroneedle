class_name Chest extends Node3D

@onready var interact_area: Area3D = $Area3D
@onready var hare_spawn_pt: Marker3D = $Marker3D
@onready var hare: Hare = $Hare
@onready var smoke: SmokeParticle = $SmokeParticle

var ignore_input: bool = false

func _ready() -> void:
	hare.hide()
	pass

func _process(delta: float) -> void:
	if ignore_input: return
	
	if Input.is_action_just_pressed("interact"):
		if (get_parent() as Room).has_enemies_alive(): return
		for b in interact_area.get_overlapping_bodies():
			if b is MainChar:
				#print("interact door")
				ignore_input = true
				
				smoke.run_once_()
				hare.show()
				hare.move_forward()
	pass
