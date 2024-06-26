class_name Zombie1State extends Node

var state_machine : Zombie1StateMachine = null
var player : Zombie1

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass

# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

func recieving_moving_input() -> bool:
	return (   Input.is_action_pressed("forward")
			|| Input.is_action_pressed("backward")
			|| Input.is_action_pressed("left")
			|| Input.is_action_pressed("right")
	)
