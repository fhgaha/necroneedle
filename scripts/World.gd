class_name World extends Node3D

@onready var main_char: MainChar = $MainChar
@onready var main_song: AudioStreamPlayer = $main_song

func _ready() -> void:
	if not G.debug:
		main_song.play()

func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "upd_trg_pos", main_char.global_position)

func reset_player_pos(player: MainChar):
	var room = $rooms.get_child(0) as Room
	player.global_position = room.spawn_pt.global_position
