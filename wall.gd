extends StaticBody3D
class_name Wall

func set_material(mat :Material) -> Wall:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Wall:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_size(sz :Vector2) -> Wall:
	$MeshInstance3D.mesh.size = sz
	return self

func set_info(s :String, pixel_size :float) -> Wall:
	$Label3D.text = s
	$Label3D.pixel_size = pixel_size
	return self

func get_labeltext() -> String:
	return $Label3D.text
