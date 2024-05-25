class_name Zombie1Moving extends Zombie1State

func enter(_msg := {}) -> void:
	#print("z entered moving")
	player.play_anim("walk")
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.process_moving()
	pass

func exit() -> void:
	pass
