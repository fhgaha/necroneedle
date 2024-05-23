class_name Zombie1StateMachine extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

var state_to_string : String : 
	get:
		return state.name
# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: Zombie1State = get_node(initial_state)

var player : Zombie1
var is_configured : bool = false

func config() -> void:
	#await owner.is_node_ready()
	player = owner
	for child in get_children():
		var s = child as Zombie1State
		s.state_machine = self
		s.player = player
	
	is_configured = true
	state.enter()

# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	if (!is_configured): return
	state.handle_input(event)

func _process(delta: float) -> void:
	if (!is_configured): return
	state.update(delta)

func _physics_process(delta: float) -> void:
	if (!is_configured): return
	state.physics_update(delta)

# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if (!is_configured): return
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name): return
	if state != null && state.name == target_state_name: return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	#print("%s: %s, %s" % [self.name, player.target.name, state.name])
	emit_signal("transitioned", state.name)
