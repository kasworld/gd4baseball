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

func 휘두르기() -> void:
	#$HingeJoint3D.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, false)
	$HingeJoint3D.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, -PI*3)
	#$HingeJoint3D.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, true)
	$Timer.start(0.5)

func 되감기() -> void:
	$HingeJoint3D.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, PI*3)
	
func _on_timer_timeout() -> void:
	되감기()
