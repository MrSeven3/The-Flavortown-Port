extends Node

var current_scene:String

func log(caller:Node,message:String) -> void:
	print("["+str(caller.get_path())+"] "+message)
