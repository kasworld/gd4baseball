extends Node3D

var ball_droped :int
var dark_colors :Array

func get_randomcolor() -> Color:
	var co = dark_colors.pop_front()
	dark_colors.push_back(co)
	return co[0]

func _ready() -> void:
	dark_colors = NamedColorList.make_dark_color_list(0.5)
	dark_colors.shuffle()
	reset_camera_pos()
	set_walls()
	add_반사판()
	var co = get_randomcolor()
	var l = Config.BallRadius*6
	var w = Config.BallRadius/3
	var w2 = Config.BallRadius*1
	$Arrow3DShoot.set_color(co).set_size(l,w,w2)
	$Arrow3DShoot.position = Config.WorldSize/2 + Vector3(0,0,-Config.WorldSize.z/4)
	$"야구베트".position = Config.WorldSize/2 + Vector3(-2,0,Config.WorldSize.z/4)

func add_반사판() -> void:
	var w
	var co 
	var co1 = get_randomcolor()
	var co2 = get_randomcolor()
	var rad
	for deg in range(90,270,5):
		rad = deg_to_rad(deg)
		co = lerp(co1,co2, float(deg) / 180.0 )
		w = preload("res://반사판.tscn").instantiate().set_color(co)
		w.rotate_y(PI+rad)
		w.position = Vector3(sin(rad), 0, cos(rad))*Config.WorldSize.x/2 + Config.WorldSize/2
		add_child(w)

	#co = get_randomcolor()
	#rad = deg_to_rad(45)
	#var pos_z := Config.BounceArchRadius -0.5 
	#w = preload("res://반사판.tscn").instantiate().set_color(co)
	#w.rotate_y(PI-rad)
	#w.position = Vector3(sin(rad)*0.7, Config.WorldSize.y/2, pos_z )
	#add_child(w)
	#w = preload("res://반사판.tscn").instantiate().set_color(co)
	#w.rotate_y(PI+rad)
	#w.position = Vector3(Config.WorldSize.x-sin(rad)*0.7, Config.WorldSize.y/2, pos_z)
	#add_child(w)

func set_walls() -> void:
	$WallContainer.add_child(set_pos_rot(Config.BottomCenter, Vector3.ZERO,
		preload("res://wall.tscn").instantiate().set_size(Config.BottomSize).set_info("바닥", 0.1).set_color(Color.DARK_GREEN)
	))
	$WallContainer.add_child(set_pos_rot(Config.TopCenter, Vector3(PI,0,0),
		preload("res://wall.tscn").instantiate().set_size(Config.BottomSize).set_info("천장", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.WestCenter, Vector3(0,0,-PI/2),
		preload("res://wall.tscn").instantiate().set_size(Config.WestSize).set_info("서쪽", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.EastCenter, Vector3(0,0,PI/2),
		preload("res://wall.tscn").instantiate().set_size(Config.WestSize).set_info("동쪽", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.NorthCenter, Vector3(PI/2,0,0),
		preload("res://wall.tscn").instantiate().set_size(Config.NorthSize).set_info("북쪽", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.SouthCenter, Vector3(-PI/2,0,0),
		preload("res://wall.tscn").instantiate().set_size(Config.NorthSize).set_info("남쪽", 0.1)
	))

func set_pos_rot(pos :Vector3, rot:Vector3, n: Node3D) -> Node3D:
	n.position = pos
	n.rotation = rot
	return n

func shoot_ball(pos :Vector3) -> void:
	var 발사속도 = $"왼쪽패널/발사속도".value
	var d = 	preload("res://ball.tscn").instantiate().start_life(
		#).set_material(Config.tex_array.pick_random()
		).set_radius(Config.BallRadius
	)
	d.set_velocity(Vector3(0,0,발사속도))
	$BallContainer.add_child(d)
	ball_droped += 1
	d.ball_ended.connect(ball_ended)
	d.position = pos + Vector3(0,0,Config.BallRadius*4)

func ball_ended(pos :Vector3) -> void:
	pass

var camera_move = false
func _process(delta: float) -> void:
	if $BallContainer.get_child_count() > 0:
		var firstball = $BallContainer.get_child(0)
		if firstball.get_life_dur() > 3:
			firstball.queue_free()
	
	update_label()
	$Arrow3DShoot.position.x = $"왼쪽패널/화살표위치".value/100*(Config.WorldSize.x-Config.BallRadius)
	$Arrow3DShoot.position.x = clampf($Arrow3DShoot.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)
	
	var t = Time.get_unix_time_from_system() /-3.0
	if camera_move:
		$Camera3D.position = Vector3(sin(t)*Config.WorldSize.x/2, Config.BottomSize.length()*0.4, cos(t)*Config.WorldSize.z/2) + Config.WorldSize/2
		$Camera3D.look_at(Config.BottomCenter)

func update_label() -> void:
	$"왼쪽패널/LabelDrops".text = "ball drops %s" %[ball_droped]
	$"왼쪽패널/LabelPerformance".text = """%d FPS (%.2f mspf)
%d objects
%dK primitive indices
%d draw calls""" % [
	Engine.get_frames_per_second(),1000.0 / Engine.get_frames_per_second(),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_OBJECTS_IN_FRAME),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_PRIMITIVES_IN_FRAME) * 0.001,
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME),
	]

func _on_왼쪽이동_pressed() -> void:
	$Arrow3DShoot.position.x -= 0.1
	$Arrow3DShoot.position.x = clampf($Arrow3DShoot.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)

func _on_오른쪽이동_pressed() -> void:
	$Arrow3DShoot.position.x += 0.1
	$Arrow3DShoot.position.x = clampf($Arrow3DShoot.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
	KEY_ENTER:_on_카메라변경_pressed,
	KEY_LEFT: _on_왼쪽이동_pressed,
	KEY_RIGHT: _on_오른쪽이동_pressed,
}
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var fn = key2fn.get(event.keycode)
		if fn != null:
			fn.call()
	elif event is InputEventMouseButton and event.is_pressed():
		pass

func _on_button_esc_pressed() -> void:
	get_tree().quit()

func _on_카메라변경_pressed() -> void:
	camera_move = !camera_move
	if camera_move == false:
		reset_camera_pos()

func reset_camera_pos()->void:
	$Camera3D.position = Vector3(Config.WorldSize.x/2, Config.BottomSize.length()*0.45, Config.WorldSize.z * 0.8)
	$Camera3D.look_at(Vector3(Config.WorldSize.x/2,0,Config.WorldSize.z*0.6))
	$Camera3D.far = Config.WorldSize.length()

func _on_timer공추가_timeout() -> void:
	shoot_ball($Arrow3DShoot.position)

func _on_생성속도_value_changed(value: float) -> void:
	$"Timer공추가".wait_time = value
