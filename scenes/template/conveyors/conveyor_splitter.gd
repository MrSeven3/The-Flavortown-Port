extends Node3D

var is_left := false

func spilt(object:Node3D):
	if object.has_meta("pickupable"): #just verifies that this is a package, theres probably a way to do this with instancing, but idrc rn
		if is_left:
			is_left = false
			object.set_collision_mask_value(7,true) #makes it only interact with the left conveyor
			object.set_collision_layer_value(7,true)
		elif not is_left:
			is_left = true
			object.set_collision_mask_value(8,true) #makes it only interact with the right conveyor
			object.set_collision_layer_value(8,true)

func stop_splitting(object:Node3D):
	if object.has_meta("pickupable"): #just verifies that this is a package, theres probably a way to do this with instancing, but idrc rn
		object.set_collision_mask_value(7,false)# makes the package interact with no splitter conveyors
		object.set_collision_layer_value(7,false)
		object.set_collision_mask_value(8,false)
		object.set_collision_layer_value(8,false)
