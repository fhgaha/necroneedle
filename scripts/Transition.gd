class_name TransitionScreen extends Control

var mat: ShaderMaterial

func _ready() -> void:
	mat = $ColorRect.material
	pass

func fade_in():
	mat.set("shader_parameter/position", 1.0)
	var t = create_tween()
	t.tween_property(mat, "shader_parameter/position", -1.5, 1.5).set_trans(Tween.TRANS_QUAD)
	await  t.finished
	pass

func fade_out():
	mat.set("shader_parameter/position", -1.5)
	var t = create_tween()
	t.tween_property(mat, "shader_parameter/position", 1, 1.5).set_trans(Tween.TRANS_QUAD)
	await  t.finished
	pass
