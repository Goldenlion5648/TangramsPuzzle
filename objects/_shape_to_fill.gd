extends CSGBox3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.check_answer.connect(check_level_complete)

func check_level_complete():
	var max_wait = .3
	var time_to_wait = .02
	var total_time_waited = 0
	var old_aabb = get_aabb()
	while old_aabb == get_aabb() and total_time_waited < max_wait:
		total_time_waited += time_to_wait
		await get_tree().create_timer(time_to_wait).timeout
	if get_aabb().size == Vector3(0,0,0):
		Globals.level_complete.emit()
	else:
		Globals.put_back_shapes.emit()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
