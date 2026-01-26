extends RigidBody3D
var target_velocity
var velocity := Vector3.ZERO
var current_applied_speed:Vector3
var force_applied_speed:bool = false

@export var bounce:float = 0.3

func apply_speed(speed:Vector3, force:bool) -> void: #called by conveyor belts
	current_applied_speed = speed
	force_applied_speed = force
	apply_central_force(current_applied_speed)

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta #Apply gravity
	var impact = move_and_collide(velocity*delta) #Built in function to have nice movement, velocity, and collision
	
	if impact != null:
		var impact_normal = impact.get_normal()
		
		velocity = velocity.bounce(impact_normal)
		velocity *= bounce
		
		impact = null
		impact = move_and_collide(velocity*delta)
