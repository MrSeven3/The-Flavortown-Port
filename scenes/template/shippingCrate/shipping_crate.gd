extends RigidBody3D
var velocity := Vector3.ZERO
var belt_velocity:Vector3 = Vector3.ZERO
var is_on_belt:bool = false

var conveyor_force := Vector3(3,3,3)
var conveyor_dir := Vector3.ZERO

@export var bounce:float = 0.3

func apply_dir(dir:Vector3) -> void: #called by conveyor belts
	conveyor_dir += dir

func clear_velocity() -> void:
	velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	Utils.log(self,str(velocity))
	velocity += get_gravity() * delta #Apply gravity
	
	if is_on_belt:
		#alt solution is to keep a list of directions, average them to get final direction and then project if this doesn't work.
		belt_velocity = conveyor_force * (conveyor_dir)
		
		#these 3 lines are AI, because vectors suck and im sorry
		# Override the velocity in the direction of the belt velocity
		var belt_motion = belt_velocity.normalized()# * belt_velocity.length()
		var current_motion = velocity.project(belt_velocity.normalized())
				
		#me again for this if statemetn
		if is_nan(current_motion.x) or is_nan(current_motion.y) or is_nan(current_motion.z):# and typeof(current_motion) == TYPE_FLOAT:
			breakpoint
			
		
		#ai again for this line
		# Update velocity only along the belt direction, preserving other motion
		velocity += belt_motion - current_motion
		
	
	#print(str(is_on_belt))
	#print(str(velocity))
	var impact = move_and_collide(velocity*delta) #Built in function to have nice movement, velocity, and collision
	
	if impact != null:
		var impact_normal = impact.get_normal()
		
		velocity = velocity.bounce(impact_normal)
		velocity *= bounce
		
		impact = null
		impact = move_and_collide(velocity*delta)
