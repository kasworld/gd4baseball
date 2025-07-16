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
	add_수비수들()
	$"야구베트".position = 베이스위치.홈 + Vector3(-1.5,0,0)
	$"야구베트".set_radius_height(Config.BallRadius/2, Config.WorldSize.y)

var 베이스위치 :Dictionary
var 수비수이름위치 :Dictionary 
func add_수비수들() -> void:
	수비수이름위치 = {}
	베이스위치 = {}
	var 내야shift = Config.WorldSize.x / 4
	var 투수위치 = Config.WorldSize/2 
	투수위치.z = Config.WorldSize.z - 내야shift -2
	베이스위치["홈"] = 투수위치 + Vector3(0,0,내야shift)
	베이스위치["1루"] = 투수위치 + Vector3(내야shift,0,0)
	베이스위치["2루"] = 투수위치 + Vector3(0,0,-내야shift)
	베이스위치["3루"] = 투수위치 + Vector3(-내야shift,0,0)
	수비수이름위치["투수"] = 투수위치
	수비수이름위치["포수"] = 베이스위치["홈"] + Vector3(0,0,2)
	수비수이름위치["1루수"] = 베이스위치["1루"] + Vector3(-1,0,0)
	수비수이름위치["3루수"] = 베이스위치["3루"] + Vector3(1,0,0)
	수비수이름위치["2루수"] = 베이스위치["2루"] + Vector3(3,0,0)
	수비수이름위치["유격수"] = 베이스위치["2루"] + Vector3(-3,0,0)
	수비수이름위치["중견수"] = 베이스위치["2루"] + Vector3(0,0,-내야shift)
	수비수이름위치["우익수"] = 베이스위치["2루"] + Vector3(내야shift*1.5,0,-내야shift)
	수비수이름위치["좌익수"] = 베이스위치["2루"] + Vector3(-내야shift*1.5,0,-내야shift)
	for n in 수비수이름위치.keys():
		add_수비수(n)
	for n in 베이스위치:
		add_베이스(n)
	add_line(베이스위치["홈"], 베이스위치["1루"])
	add_line(베이스위치["2루"], 베이스위치["1루"])
	add_line(베이스위치["3루"], 베이스위치["2루"])
	add_line(베이스위치["3루"], 베이스위치["홈"])

func add_수비수(name :String) -> 수비수:
	var b = preload("res://수비수.tscn").instantiate().set_color( get_randomcolor()
		).set_label(name
		).set_radius_height(Config.BallRadius/2, Config.WorldSize.y)
	b.position = 수비수이름위치[name]
	b.set_default_pos(b.position) 
	$PinContainer.add_child(b)
	return b	
	
func add_베이스(name :String) -> void:
	var minst = MeshInstance3D.new()
	minst.mesh = CylinderMesh.new()
	minst.mesh.height = 0.01
	minst.mesh.top_radius = 0.3
	minst.mesh.bottom_radius = 0.3
	minst.mesh.material = StandardMaterial3D.new()
	#minst.mesh.material.albedo_color = get_randomcolor()
	minst.position = 베이스위치[name]
	minst.position.y = 0.01
	add_child(minst)

func add_line(p1 :Vector3, p2 :Vector3) -> void:
	var minst = MeshInstance3D.new()
	minst.mesh = BoxMesh.new()
	var l = (p1-p2).length()
	minst.mesh.size = Vector3(l,0.01,0.1)
	minst.mesh.material = StandardMaterial3D.new()
	#minst.mesh.material.albedo_color = get_randomcolor()
	minst.position = (p1+p2)/2
	minst.position.y = 0.01
	minst.rotate_y( (p2-p1).angle_to(Vector3.FORWARD) )
	add_child(minst)


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
		).set_radius(Config.BallRadius
	)
	d.set_velocity(Vector3(0,0,발사속도))
	$BallContainer.add_child(d)
	ball_droped += 1
	d.ball_ended.connect(ball_ended)
	d.position = pos + Vector3(0,0,Config.BallRadius*2)

func ball_ended(pos :Vector3) -> void:
	pass

var camera_move = false
func _process(delta: float) -> void:
	if $BallContainer.get_child_count() > 0:
		var firstball = $BallContainer.get_child(0)
		if firstball.get_life_dur() > 3:
			firstball.queue_free()
	update_label()
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

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
	KEY_ENTER:_on_카메라변경_pressed,
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
	shoot_ball(수비수이름위치.투수)

func _on_생성속도_value_changed(value: float) -> void:
	$"Timer공추가".wait_time = value
