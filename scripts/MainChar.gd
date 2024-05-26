class_name MainChar extends CharacterBody3D

@onready var cam: Camera3D = %cam
@onready var state_machine: StateMachine = $state_machine
@onready var anim_player: AnimationPlayer = $main_char/AnimationPlayer
@onready var root: Node3D = $main_char/Root
@onready var sound: AudioStreamPlayer3D = $sound
@onready var death_popup: Control = $death_popup
@onready var wpn_scaler: Node3D = $main_char/Root/Skeleton3D/BoneAttachment3D/weapon_scaler
const DEFAULT_WEAPON = preload("res://scenes/weapons/default_weapon.tscn")
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
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
	
	death_popup.hide()
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
	sound.play()
	cur_health -= 1
	mat.albedo_texture = null
	await get_tree().create_timer(0.2).timeout
	mat.albedo_texture = tex
	dmg_locked = false
	
	if cur_health <= 0:
		death()
	pass

func _on_yes_button_up() -> void:
	$main_char.show()
	rotation = Vector3.ZERO
	death_popup.hide()
	cur_health = health_max
	var world = get_parent() as World
	world.reset_player_pos(self)
	pass

func _on_no_button_up() -> void:
	get_tree().quit()
	pass

func death():
	$main_char.hide()
	($smoke as SmokeParticle).run_once_()
	death_popup.show()

func _on_death_area_body_entered(body: Node3D) -> void:
	if body is MainChar:
		death()
	pass

var push_force = 1.0
func push():
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func take_in_hand(wpn: WeaponInHand):
	for c in wpn_scaler.get_children():
		c.queue_free()
	
	await get_tree().process_frame
	wpn.name = "default_weapon"
	wpn.reparent(wpn_scaler, false)
	wpn.position = Vector3.ZERO
	wpn.rotation = Vector3.ZERO
	wpn.broken.connect(on_weapon_break)
	#(wpn.find_child("CollisionShape3D") as CollisionShape3D).disabled = true
	pass

func on_weapon_break(sender: WeaponInHand):
	assert(sender.broken.is_connected(on_weapon_break))
	sender.disconnect("broken", on_weapon_break)
	
	var def_wpn = DEFAULT_WEAPON.instantiate()
	sender.queue_free()
	wpn_scaler.add_child(def_wpn)
	await get_tree().process_frame
	def_wpn.name = "default_weapon"
	pass
