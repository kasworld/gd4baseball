extends StaticBody3D
class_name 칸막이

func set_material(mat :Material) -> 칸막이:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> 칸막이:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_size(v3 :Vector3) -> 칸막이:
	$MeshInstance3D.mesh.size = v3
	$CollisionShape3D.shape.size = v3
	return self
