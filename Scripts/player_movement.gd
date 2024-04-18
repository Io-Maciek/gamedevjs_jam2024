extends CharacterBody3D


@export var RUN_SPEED_MULTIPLIER = 1.5;
@export var SPEED = 5.0

@export var SHOULD_JUMP_ABILITY: bool = true
@export var JUMP:float = 0.0 # jump multiplier
@export var MAX_JUMP_VALUE:float = 5.0 
@export var MIN_JUMP_VALUE:float = 5.0

var jump_was_big:bool = false
var mouseAccumulatedMovement = Vector2(0, 0)
var is_pressing_jump:bool = false
var is_crouched:bool = false
var _READY_FOR_NEXT_ANIMATION:bool = true # TODO


@export var mouseSensitivity = 0.1
@export var gamepadSensitivity =  4.0
@onready var camera = $Body/CameraHolder/Camera3D
@onready var animation = $AnimationPlayer
@onready var sound_jump_loading = $AudioStreamLoadingJump
@onready var crouch_ray_cast = $CrouchRayCast
@onready var jump_slider = $CanvasLayer/MarginContainer/JumpSlider
@onready var audio_jump = $AudioStreamJump
@onready var audio_wind = $AudioStreamWind
@onready var audio_landing = $AudioStreamLanding

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass
	
func _process(_delta):
	#if !is_pressing_jump and jump_slider.visible:
		#jump_slider.visible = false
	
	if !is_on_floor() and jump_was_big:
		#var vel2d = Vec(velocity.x, velocity.z)
		#print(vel2d.length_squared() / 56.0)
		if !audio_wind.playing:
			audio_wind.play()
	
	if is_on_floor():
		if jump_was_big:
			audio_landing.play()
		jump_was_big = false
		if audio_wind.playing:
			audio_wind.stop()


func _physics_process(delta):
	HandleCrouch()
	HandleJumping()
	MouseMovement()
	Movement(delta)

func _input(event):
	if event is InputEventMouseMotion: 
		mouseAccumulatedMovement += event.relative

func HandleCrouch():
	if is_pressing_jump:
		return
		
	#crouch_ray_cast.is_colliding()
	var action_press = Input.is_action_pressed("crouch")
	if action_press and is_on_floor():
		if !is_crouched:
			animation.play("crouch")
		is_crouched = true
	elif !action_press and !crouch_ray_cast.is_colliding():
		if is_crouched:
			animation.play_backwards("crouch")
			animation.queue("idle_better")
		is_crouched = false

func HandleJumping():
	if is_crouched:
		return
	# Handle jump.
	if is_pressing_jump:
		#if !is_on_floor():
		#	StopJumpAction()
		if Input.is_action_just_released("jump"):
			StopJumpAction()
	else:
		#animation.play("idle_better")
		if Input.is_action_just_pressed("jump") and is_on_floor():
			StartJumpAction()
			

func MouseMovement():
	var gamepadMovement:Vector2 = Input.get_vector("gamepad_look_up", "gamepad_look_down", "gamepad_look_left", "gamepad_look_right")
	
	rotation_degrees = Vector3(
		rotation_degrees.x,
		rotation_degrees.y - (mouseAccumulatedMovement.x * mouseSensitivity) - (gamepadMovement.y* gamepadSensitivity),
		rotation_degrees.z
	)
	
	
	var clamped_X_value = clamp(
		camera.rotation_degrees.x - (mouseAccumulatedMovement.y * mouseSensitivity)
			- (gamepadMovement.y * gamepadSensitivity),
		-90, 
		90
	)

	#moving only camera child in player object up and down
	camera.rotation_degrees = Vector3(
		clamped_X_value,
		camera.rotation_degrees.y,
		camera.rotation_degrees.z)
	mouseAccumulatedMovement = Vector2(0, 0)


func Movement(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	var speed_multiplier = 1.0
	if !is_crouched and !is_pressing_jump and Input.is_action_pressed("run"):
		speed_multiplier = RUN_SPEED_MULTIPLIER

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("go_left", "go_right", "go_forward", "go_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * speed_multiplier
		velocity.z = direction.z * SPEED * speed_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speed_multiplier)
		velocity.z = move_toward(velocity.z, 0, SPEED * speed_multiplier)

	move_and_slide()

func StartJumpAction():
	is_pressing_jump = true
	animation.play("jumping_better")
	if !SHOULD_JUMP_ABILITY:
		StopJumpAction()

func StopJumpAction():
	jump_slider.visible = false
	is_pressing_jump = false
	velocity.y = JUMP * MAX_JUMP_VALUE + MIN_JUMP_VALUE
	
	if JUMP > 0.1:
		jump_was_big = true
		audio_jump.volume_db = 0
	else:
		audio_jump.volume_db = -10
	animation.play("idle_better")	
	sound_jump_loading.stop()
	audio_jump.play()
	

func _on_animation_player_animation_finished(anim_name):
	_READY_FOR_NEXT_ANIMATION = true;
	if str(anim_name) == "jumping_better":
		#animation.play("idle_better")
		StopJumpAction()
