class_name MainChar extends CharacterBody3D

@onready var cam: Camera3D = %cam
@onready var state_machine: StateMachine = $state_machine
@onready var anim_player: AnimationPlayer = $main_char/AnimationPlayer

func _ready() -> void:
	state_machine.config()

func _physics_process(delta: float) -> void:
	pass

func play_anim(name: String):
	if anim_player.current_animation != name:
		anim_player.play(name)
