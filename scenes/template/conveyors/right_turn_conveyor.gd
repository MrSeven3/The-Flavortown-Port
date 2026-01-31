extends RigidBody3D

@export var conveyor_belt_dir = Vector3(1,0,-1) #mirrored for some reason I don't care to figure out
var rotated_belt_dir:Vector3

#unoptimized ahh logic, but it works, only does overlap checks every frame

func _physics_process(_delta: float) -> void:
	rotated_belt_dir = global_transform.basis * conveyor_belt_dir
	
	var intersecting_objects = $Area3D.get_overlapping_bodies()
	for object in intersecting_objects:
		if object.has_method("apply_dir"):
			object.is_on_belt = true
			#object.call("apply_dir",rotated_belt_dir)

func conveyor(object:Node3D) -> void:
	if object.has_method("apply_dir"):
		rotated_belt_dir = global_transform.basis * conveyor_belt_dir
		object.is_on_belt = true
		object.call("apply_dir",rotated_belt_dir)

func stop_conveyoring(object:Node3D) -> void:
	if object.has_method("apply_dir"):
		rotated_belt_dir = global_transform.basis * conveyor_belt_dir
		object.is_on_belt = false
		object.call("apply_dir",-rotated_belt_dir)
