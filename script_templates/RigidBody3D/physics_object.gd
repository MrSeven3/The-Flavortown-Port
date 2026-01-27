extends RigidBody3D
var velocity := Vector3.ZERO
var belt_velocity:Vector3 = Vector3.ZERO
var is_on_belt:bool = false

@export var bounce:float = 0.3

func apply_speed(speed:Vector3) -> void: #called by conveyor belts
	belt_velocity = speed

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta #Apply gravity
	
	if is_on_belt:
		#these 3 lines are AI, because vectors suck and im sorry
		# Override the velocity in the direction of the belt velocity
		var belt_motion = belt_velocity.normalized() * belt_velocity.length()
		var current_motion = velocity.project(belt_velocity.normalized())
		
		# Update velocity only along the belt direction, preserving other motion
		velocity += belt_motion - current_motion
		
	var impact = move_and_collide(velocity*delta) #Built in function to have nice movement, velocity, and collision
	
	if impact != null:
		var impact_normal = impact.get_normal()
		
		velocity = velocity.bounce(impact_normal)
		velocity *= bounce
		
		impact = null
		impact = move_and_collide(velocity*delta)
