extends Node

var debug: bool = false

func transition_to(prev_room: Room, next_room: PackedScene):
	#print(sender, next_room)
	var scene = get_tree().current_scene
	var trans = scene.get_node("transition") as TransitionScreen
	#await trans.fade_in()
	
	prev_room.queue_free()
	var r: Room = next_room.instantiate()
	#$".".add_child(r)
	scene.get_node("rooms").add_child(r)
	var main_char = scene.get_node("MainChar")
	main_char.global_position = r.spawn_pt.global_position
	
	#await trans.fade_out()
	pass
