extends CSGBox3D

class_name MovingPiece

var shape_to_fill: CSGBox3D
var is_currently_selected = false
@export var starting_material: Material
var material_to_use

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape_to_fill = get_node("../_shapeToFill")
	material_to_use = starting_material
	change_material_to_use()

func _input(event: InputEvent) -> void:
	if not is_currently_selected:
		return
	
	if event.is_action_pressed("move_left"):
		self.position.x -= 1
	elif event.is_action_pressed("move_right"):
		self.position.x += 1
	elif event.is_action_pressed("move_away"):
		self.position.z -= 1
	elif event.is_action_pressed("move_closer"):
		self.position.z += 1
		
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("drop"):
		self.position.y = 0
		Globals.piece_dropped_signal.emit()
	
func set_material_and_children():
	self.material = material_to_use
	for child in get_children():
		child.material = material_to_use

func change_material_to_use():
	while true:
		await get_tree().create_timer(.6).timeout
		if not self.is_currently_selected:
			material_to_use = starting_material
		elif material_to_use == null:
			material_to_use = starting_material
		else:
			material_to_use = null
		
		set_material_and_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
