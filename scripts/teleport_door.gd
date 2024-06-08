extends Node3D

class_name TeleportDoor

var open := false
signal DoorClicked

func interact():
	DoorClicked.emit()
	
