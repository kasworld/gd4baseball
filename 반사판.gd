extends StaticBody3D
class_name 반사판

func set_material(mat :Material) -> 반사판:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> 반사판:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_size(v2 :Vector2) -> 반사판:
	$MeshInstance3D.mesh.size = v2
	#$CollisionShape3D.shape.size = v3
	return self
