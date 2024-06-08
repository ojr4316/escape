extends CharacterBody3D

@export var walk_speed = 6.5
@export var run_speed = 11
@export var slow_speed = 3
@export var jump = 4
@export var zoom_fov = 30

@export var flashlight_energy = 0.6
var flashlightOn = false

var fov = 75

var speed = 7 # Current Speed

var look_sensitivity = 0.005
var gravity = 15
var velocity_y = 0

var canMove := false

@onready var camera:Camera3D = $Camera3D
@onready var interactor: Area3D = $Camera3D/Interactor
@onready var flashlight: SpotLight3D = $Camera3D/SpotLight3D

@onready var start_overlay: CanvasLayer = $StartOverlay
@onready var start_timer: Timer = $StartTimer

var show_phone = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	start_timer.start(1.2)

func _physics_process(delta):
	# Cancel movement if in dialogue (or cutscene or something)
	if !canMove:
		return
	
	# Basic Movement
	var horizontal = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").normalized()
	
	speed = run_speed if Input.is_action_pressed("sprint") else (slow_speed if Input.is_action_pressed("zoom") else walk_speed)
	
	velocity = (horizontal.x * global_transform.basis.x + horizontal.y * global_transform.basis.z) * speed
	if is_on_floor():
		velocity_y = 0
		if Input.is_action_just_pressed("jump"): 
			velocity_y = jump
	else:
		velocity_y -= gravity * delta
	velocity.y = velocity_y
	move_and_slide()
	
	# Lock/unlock mouse
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE
	
	camera.fov = zoom_fov if Input.is_action_pressed("zoom") else fov
	
func _input(event):
	# Camera Movement	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * look_sensitivity)
		camera.rotate_x(-event.relative.y * look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
	# Player Interacting
	if event.is_action_pressed("interact"):
		var interactable = interactor.get_interactable()
		print(interactable)
		if interactable != null:
			interactable.interact()
	
	if event.is_action_pressed("flashlight"):
		if flashlightOn:
			flashlightOn = false
			flashlight.light_energy = 0
		else:
			flashlightOn = true
			flashlight.light_energy = flashlight_energy
	

func set_move(t):
	canMove = t

func show_overlay():
	start_overlay.show()
	start_timer.start(0.8)

func _on_start_timer_timeout() -> void:
	canMove = true
	start_overlay.hide()
