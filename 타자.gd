extends Node3D
class_name 타자

func set_label(s :String) -> 타자:
	$Label3D.text = s
	return self

func set_radius_height(r :float, h:float) -> 타자:
	$"StaticBody3D/막대모양".mesh.top_radius = r
	$"StaticBody3D/막대모양".mesh.bottom_radius = r
	$"StaticBody3D/막대모양".mesh.height = h
	$"StaticBody3D/공모양".mesh.radius = r *1.5
	$"StaticBody3D/공모양".mesh.height = $"StaticBody3D/공모양".mesh.radius*2
	$"StaticBody3D/공모양".position.y = h/2
	$StaticBody3D/CollisionShape3D.shape.radius = r
	$StaticBody3D/CollisionShape3D.shape.height = h
	return self
