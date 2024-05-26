class_name Weapon extends RigidBody3D

@onready var player_detector_shape: CollisionShape3D = $player_detector/CollisionShape3D
@onready var dmg_dealer: Area3D = $dmg_dealer
@onready var dmg_dealer_shape: CollisionShape3D = $dmg_dealer/CollisionShape3D

var player : MainChar

func _on_player_detector_body_entered(body: Node3D) -> void:
	player = body as MainChar

func _on_player_detector_body_exited(body: Node3D) -> void:
	player = body as MainChar

func _process(delta: float) -> void:
	if player && Input.is_action_just_pressed("interact"):
		dmg_dealer_shape.disabled = false
		await player.take_in_hand(dmg_dealer)
		queue_free()
		pass
