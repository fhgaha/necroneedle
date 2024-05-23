class_name MainChar extends CharacterBody3D

@onready var cam: Camera3D = %cam
@onready var state_machine: StateMachine = $state_machine
@onready var anim_player: AnimationPlayer = $main_char/AnimationPlayer
@onready var root: Node3D = $main_char/Root
@onready var weapon: Area3D = $main_char/Root/Skeleton3D/BoneAttachment3D/weapon
var dmg_locked : bool = false
var health_max : int = 5
var cur_health: int = 5
var tex : Texture2D
var mat : StandardMaterial3D

func _ready() -> void:
	state_machine.config()
	
	var mesh = $main_char/Root/Skeleton3D/characterMedium as MeshInstance3D
	mat = mesh.get_active_material(0) as StandardMaterial3D
	tex = mat.albedo_texture
	pass

func _physics_process(delta: float) -> void:
	pass

func play_anim(name: String):
	if anim_player.current_animation != name:
		anim_player.play(name)
	pass

func cur_anim_length() -> float:
	return anim_player.current_animation_length

func _on_damage_reciever_area_entered(area: Area3D) -> void:
	if dmg_locked: return
	
	dmg_locked = true
	#print("_on_damage_reciever_area_entered")
	cur_health -= 1
	print(cur_health)
	mat.albedo_texture = null
	await get_tree().create_timer(0.2).timeout
	mat.albedo_texture = tex
	dmg_locked = false
	
	if cur_health <= 0:
		print("game over")
		#queue_free()
	pass
	pass
