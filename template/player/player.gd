extends CharacterBody3D

const mouse_sensitivity = 0.002

const regular_speed = 2.5
const sprint_speed = 4.5
var speed:float

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event): #called on inputs(mouse movements and keypressed)
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: #moves the camera
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		$CameraAnchor.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor.rotation.x = clampf($CameraAnchor.rotation.x, -deg_to_rad(90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	velocity.x = 0
	velocity.z = 0
	
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
	
	velocity += get_gravity()
	move_and_slide()
