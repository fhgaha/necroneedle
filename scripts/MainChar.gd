class_name MainChar extends CharacterBody3D

@onready var cam: Camera3D = %cam
@onready var state_machine: StateMachine = $state_machine
@onready var anim_player: AnimationPlayer = $main_char/AnimationPlayer
@onready var root: Node3D = $main_char/Root
@onready var weapon: Area3D = $main_char/Root/Skeleton3D/BoneAttachment3D/weapon

func _ready() -> void:
	state_machine.config()
	pass

func _physics_process(delta: float) -> void:
	pass

func play_anim(name: String):
	if anim_player.current_animation != name:
		anim_player.play(name)
	pass

func cur_anim_length() -> float:
	return anim_player.current_animation_length
