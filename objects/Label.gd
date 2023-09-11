extends Label


func _ready() -> void:
	self.hide()
	Globals.level_complete.connect(reveal)

func reveal():
	self.show()
