class_name Zombie1 extends CharacterBody3D

var health_max : int = 3
var cur_health: int = 3

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var dmg_reciever: Area3D = $damage_reciever
var tex : Texture2D
var mat : StandardMaterial3D
var dmg_locked : bool = false

func _ready() -> void:
	var mesh = $zombie1/Root/Skeleton3D/characterMedium as MeshInstance3D
	mat = mesh.get_active_material(0) as StandardMaterial3D
	tex = mat.albedo_texture
	pass

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
	pass

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
		var smoke = $smoke as SmokeParticle
		#remove_child(smoke)
		#get_parent_node_3d().add_child(smoke)
		#smoke.global_position = global_position
		smoke.reparent_(self, get_parent_node_3d()).run_once_()
		queue_free()
	pass
