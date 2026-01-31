extends CharacterBody3D

const mouse_sensitivity:float = 0.002
const jump_vel:float = 6.5

const regular_speed:float = 3.5
const sprint_speed:float = 5.5
var speed:float

var should_jump:bool = false #means the player will jump on the next physics tick
var object_held := false
var held_object:Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func pickup_object() -> void:
	var object = $CameraAnchor/PickupRay.get_collider()
	if object and object.get_meta("pickupable",false):
		object_held = true
		object.set_collision_mask_value(1,false)
		object.set_collision_layer_value(1,false)
		held_object = object

func drop_object() -> void:
	if object_held and held_object:
		object_held = false
		held_object.clear_velocity()
		held_object.set_collision_mask_value(1,true)
		held_object.set_collision_layer_value(1,true)
		held_object = null


func _input(event): #called on inputs(mouse movements and keypressed)
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED: #moves the camera
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		$CameraAnchor.rotate_x(-event.relative.y * mouse_sensitivity)
		$CameraAnchor.rotation.x = clampf($CameraAnchor.rotation.x, -deg_to_rad(90), deg_to_rad(90))
		if object_held and held_object:
			held_object.clear_velocity()
			held_object.position = $CameraAnchor/ObjectHeldMarker.global_position
			held_object.rotation = $CameraAnchor/ObjectHeldMarker.global_rotation
	elif event is InputEventKey:
		if event.keycode == KEY_SPACE and not event.is_released() and is_on_floor():
			should_jump = true
		elif event.keycode == KEY_E and not event.is_released() and not event.is_echo():
			#object pick up and drop logic
			if not object_held:
				pickup_object()
			else:
				drop_object()
		elif event.keycode == KEY_ESCAPE and not event.is_released() and not event.is_echo():
			$CameraAnchor/Camera3D/EscapeMenu.visible = not $CameraAnchor/Camera3D/EscapeMenu.visible


func _physics_process(delta: float) -> void:
	if object_held and held_object:
		held_object.clear_velocity()
		held_object.position = $CameraAnchor/ObjectHeldMarker.global_position
		held_object.rotation = $CameraAnchor/ObjectHeldMarker.global_rotation
	
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
