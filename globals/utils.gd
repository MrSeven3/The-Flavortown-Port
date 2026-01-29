extends Node

func log(caller:Node,message:String) -> void:
	print("["+str(caller.get_path())+"] "+message)

func search_array(array:Array, value) -> int:
	for i in range(len(array)-1):
		if array[i] == value:
			return i
	return -1
