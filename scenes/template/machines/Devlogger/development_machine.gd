extends AnimatableBody3D

func object_entered(object:Node3D) -> void:
	if object.has_meta("pickupable"): #just verifies that this is a package, theres probably a way to do this with instancing, but idrc rn
		var object_data = object.package_data
		$StraightConveyor2.disable_belt()
