extends CharacterBody3D

const mouse_sensitivity = 0.002
const jump_vel:float = 6.5

const regular_speed = 3.5
const sprint_speed = 5.5
var speed:float

var should_jump:bool = false #means the player will jump on the next physics tick

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event): #called on inputs(mouse movements and keypressed)
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: #moves the camera
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		$CameraAnchor.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor.rotation.x = clampf($CameraAnchor.rotation.x, -deg_to_rad(90), deg_to_rad(90))
	elif event is InputEventKey:
		if event.keycode == KEY_SPACE and not event.is_released() and is_on_floor():
			should_jump = true

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	
	if should_jump and is_on_floor():
		velocity.y += jump_vel
		should_jump = false
	
	if Input.is_key_pressed(KEY_SHIFT):
		speed = sprint_speed
	else:
		speed = regular_speed
	
	if Input.is_key_pressed(KEY_W):
		velocity.z -= speed
	if Input.is_key_pressed(KEY_S):
		velocity.z += speed
	if Input.is_key_pressed(KEY_A):
		velocity.x -= speed
	if Input.is_key_pressed(KEY_D):
		velocity.x += speed
	velocity = velocity.rotated(Vector3.UP,rotation.y)
	
	velocity += get_gravity() * delta
	move_and_slide()
