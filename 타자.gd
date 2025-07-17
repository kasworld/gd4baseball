extends Node3D
class_name 타자

func set_label(s :String) -> 타자:
	$Label3D.text = s
	return self

func set_radius_height(r :float, h:float) -> 타자:
	$"선수/막대모양".mesh.top_radius = r
	$"선수/막대모양".mesh.bottom_radius = r
	$"선수/막대모양".mesh.height = h
	$"선수/공모양".mesh.radius = r *1.5
	$"선수/공모양".mesh.height = $"선수/공모양".mesh.radius*2
	$"선수/공모양".position.y = h/2
	$선수/CollisionShape3D.shape.radius = r
	$선수/CollisionShape3D.shape.height = h
	return self
