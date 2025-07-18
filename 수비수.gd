extends StaticBody3D
class_name 수비수

var default_pos :Vector3

func init(name :String, pos :Vector3) -> 수비수:
	default_pos = pos
	$Label3D.text = name
	var animation = Animation.new()
	animation.resource_name = name
	var track_index = animation.add_track(Animation.TYPE_POSITION_3D)
	animation.track_set_path(track_index, ":position")
	animation.track_insert_key(track_index,0, default_pos)
	animation.track_insert_key(track_index,1, default_pos)
	$"AnimationPlayer위치".get_animation_library("").add_animation(name, animation)
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

func 위치이동시작() -> void:
	var newrad = randf_range(0,2*PI)
	var l = $팔모양.mesh.height/4
	var 새위치 = default_pos + Vector3(sin(newrad), 0 , cos(newrad)) 
	#$"AnimationPlayer위치".pause()
	var aniname = $Label3D.text
	$AnimationPlayer위치.get_animation(aniname).track_set_key_value(0,0,position)
	$AnimationPlayer위치.get_animation(aniname).track_set_key_value(0,1,새위치)
	$"AnimationPlayer위치".play(aniname)

func _on_animation_player위치_animation_finished(anim_name: StringName) -> void:
	위치이동시작.call_deferred()
