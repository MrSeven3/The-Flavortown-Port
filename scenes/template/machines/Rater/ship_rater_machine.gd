extends StaticBody3D


func object_entered(object:Node3D) -> void:
	if object.has_meta("pickupable"): #just verifies that this is a package, theres probably a way to do this with instancing, but idrc rn
		var object_data = object.package_data
		if object_data["processing_steps"]["reviewed"] != true:
			object_data["processing_steps"]["reviewed"] = true
			object_data["processing_steps"]["passed_review"] = true #temp logic TODO: Needs to be replaced with some sort of actual logic
