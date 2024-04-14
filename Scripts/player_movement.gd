extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouseAccumulatedMovement = Vector2(0, 0)
@export var mouseSensitivity = 0.1
@export var gamepadSensitivity =  4.0
@onready var camera = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion: 
		mouseAccumulatedMovement += event.relative

func _physics_process(delta):
	MouseMovement(delta)
	Movement(delta)

func MouseMovement(delta):
	var gamepadMovement = Input.get_vector("gamepad_look_up", "gamepad_look_down", "gamepad_look_left", "gamepad_look_right")
	
	rotation_degrees = Vector3(
		rotation_degrees.x,
		rotation_degrees.y - (mouseAccumulatedMovement.x * mouseSensitivity) - (gamepadMovement.y* gamepadSensitivity),
		rotation_degrees.z
	)
	
	
	
	#moving only camera child in player object up and down
	camera.rotation_degrees = Vector3(
		clamp(
			camera.rotation_degrees.x - (mouseAccumulatedMovement.y * mouseSensitivity)
				- (gamepadMovement.y * gamepadSensitivity),
			-90, 
			90
		),
		camera.rotation_degrees.y,
		camera.rotation_degrees.z)
	mouseAccumulatedMovement = Vector2(0, 0)

func Movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
