extends StaticBody3D
class_name 수비수

var default_pos :Vector3
func set_default_pos(pos :Vector3) -> 수비수:
	default_pos = pos
	return self

func set_label(s :String) -> 수비수:
	$Label3D.text = s
	return self

func get_labeltext() -> String:
	return $Label3D.text

func set_material(mat :Material) -> 수비수:
	$몸모양.mesh.material = mat
	$"머리모양".mesh.material = mat
	$"팔모양".mesh.material = mat
	return self

func set_color(co :Color) -> 수비수:
	$몸모양.mesh.material.albedo_color = co
	$"머리모양".mesh.material.albedo_color = co
	$"팔모양".mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $몸모양.mesh.material.albedo_color

func set_radius_height(r :float, h:float) -> 수비수:
	$몸모양.mesh.top_radius = r
	$몸모양.mesh.bottom_radius = r
	$몸모양.mesh.height = h
	$팔모양.mesh.top_radius = r
	$팔모양.mesh.bottom_radius = r
	$팔모양.mesh.height = h
	$머리모양.mesh.radius = r *1.5
	$머리모양.mesh.height = $머리모양.mesh.radius*2
	$머리모양.position.y = h/2
	$CollisionShape3D.shape.size = Vector3(h,h,r*2)
	return self

func 위치변경() -> void:
	var l = $팔모양.mesh.height/4
	position = default_pos + Vector3(randfn(0.0, l), 0 , randfn(0.0, l))

func 각도변경() -> void:
	rotation.y = randfn(0.0, PI)
