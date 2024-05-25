class_name Zombie1 extends CharacterBody3D

var health_max : int = 5
var cur_health: int = 5

const SPEED: float = 1.0
const JUMP_VELOCITY: float = 4.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var dmg_reciever: Area3D = $damage_reciever
@onready var state_machine: Zombie1StateMachine = $state_machine
@onready var anim_player: AnimationPlayer = $zombie1/AnimationPlayer
@onready var weapon: Area3D = $zombie1/Root/Skeleton3D/BoneAttachment3D/weapon

var tex : Texture2D
var mat : StandardMaterial3D
var dmg_locked : bool = false
var trg_pos : Vector3 = Vector3(-100, -100, -100)

func _ready() -> void:
	var mesh_inst = $zombie1/Root/Skeleton3D/characterMedium as MeshInstance3D
	mat = mesh_inst.mesh.surface_get_material(0)
	mat = mat.duplicate()
	mesh_inst.mesh.surface_set_material(0, mat)
	tex = mat.albedo_texture
	state_machine.config()
	
	if G.debug:
		health_max = 1
		cur_health = 1
	pass

func _physics_process(delta: float) -> void:
	pass

func process_moving():
	var cur_pos = global_transform.origin
	var next_pos: Vector3 = nav_agent.get_next_path_position()
	var new_velocity = (next_pos - cur_pos).normalized() 
	nav_agent.velocity = new_velocity * SPEED
	look_at(trg_pos, Vector3.UP, true)
	
	if cur_pos.distance_to(trg_pos) <= 1.2:
		state_machine.transition_to("attacking")
	pass

func upd_trg_pos(trg_pos: Vector3):
	self.trg_pos = trg_pos
	nav_agent.target_position = trg_pos

func _on_navigation_agent_3d_target_reached() -> void:
	#state_machine.transition_to("attacking")
	pass

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
	if state_machine.state is Zombie1Moving:
		move_and_slide()

func play_anim(name: String):
	if anim_player.current_animation != name:
		anim_player.play(name)
	pass

func _on_damage_reciever_area_entered(area: Area3D) -> void:
	if dmg_locked: return
	
	print(name)
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
		smoke.reparent(get_parent_node_3d())
		smoke.run_once_()
		queue_free()
	pass
