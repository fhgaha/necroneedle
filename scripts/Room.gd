class_name Room extends Node3D

@onready var spawn_pt: Marker3D = $spawn_pt

func has_enemies_alive() -> bool:
	return get_children().any(
		func(c): 
			var _name = c.name as String
			var res: bool = _name.contains("zombie") 
			return res
			)
	pass
