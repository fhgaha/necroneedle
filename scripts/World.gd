class_name World extends Node3D

@onready var main_char: MainChar = $MainChar
@onready var main_song: AudioStreamPlayer = $main_song

var ROOM_0 = load("res://scenes/rooms/room_0.tscn")
var ROOM_1 = load("res://scenes/rooms/room_1.tscn")

func _ready() -> void:
	if not G.debug:
		main_song.play()

func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "upd_trg_pos", main_char.global_position)

