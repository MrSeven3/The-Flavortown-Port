extends RigidBody3D

@export var conveyor_belt_speed:float = 4
var conveyor_belt_dir:Vector3

#unoptimized ahh logic, but it works, only does overlap checks every frame

func _physics_process(_delta: float) -> void:
	conveyor_belt_dir = Vector3(0,0,-1) * global_transform.basis
	
	var intersecting_objects = $Area3D.get_overlapping_bodies()
	for object in intersecting_objects:
		if object.has_method("apply_dir"):
			object.is_on_belt = true
			#object.call("apply_dir",conveyor_belt_dir)

func conveyor(object:Node3D) -> void:
	if object.has_method("apply_dir"):
		conveyor_belt_dir = Vector3(0,0,-1) * global_transform.basis
		object.call("apply_dir",conveyor_belt_dir)
		object.is_on_belt = true

func stop_conveyoring(object:Node3D) -> void:
	if object.has_method("apply_dir"):
		conveyor_belt_dir = Vector3(0,0,-1) * global_transform.basis
		object.call("apply_dir",-conveyor_belt_dir)
		object.is_on_belt = false
