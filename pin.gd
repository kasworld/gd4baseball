extends StaticBody3D
class_name Pin

var default_pos :Vector3
func set_default_pos(pos :Vector3) -> Pin:
	default_pos = pos
	return self

func set_label(s :String) -> Pin:
	$Label3D.text = s
	return self

func set_material(mat :Material) -> Pin:
	$막대모양.mesh.material = mat
	$"공모양".mesh.material = mat
	return self

func set_color(co :Color) -> Pin:
	$막대모양.mesh.material.albedo_color = co
	$"공모양".mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $막대모양.mesh.material.albedo_color

func set_radius_height(r :float, h:float) -> Pin:
	$막대모양.mesh.top_radius = r
	$막대모양.mesh.bottom_radius = r
	$막대모양.mesh.height = h
	$공모양.mesh.radius = r *1.5
	$공모양.mesh.height = $공모양.mesh.radius*2
	$공모양.position.y = h/2
	$CollisionShape3D.shape.radius = r
	$CollisionShape3D.shape.height = h
	return self

var collision_count :int
func 공부딪힘(b :Ball) -> void:
	position = default_pos + Vector3(randfn(0.0, 0.01), 0 , randfn(0.0, 0.01))
	collision_count += 1
	$Label3D.text = "%s" % collision_count

func show_collision_count(b :bool) -> void:
	$Label3D.visible = b
