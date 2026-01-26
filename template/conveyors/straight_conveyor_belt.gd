extends Node3D

@export var conveyor_belt_speed:float = 5

func conveyor(object:Node3D) -> void:
	if object.has_method("apply_speed"):
		object.call("apply_speed",Vector3(0,0,-conveyor_belt_speed).rotated(Vector3.UP,global_rotation.y),false)
