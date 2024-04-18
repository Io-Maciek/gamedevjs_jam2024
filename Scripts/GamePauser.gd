extends Control
class_name GamePause

var is_paused:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		PauseHandle()

func PauseHandle():
	is_paused = !is_paused
	if is_paused:
		PauseGame()
	else:
		UnPauseGame()

func PauseGame():
	get_tree().paused = true
	Engine.time_scale = 0.0
	visible = true
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	
func UnPauseGame():
	get_tree().paused = false
	Engine.time_scale = 1.0
	visible = false
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)


func _on_btn_resume_pressed():
	PauseHandle()
