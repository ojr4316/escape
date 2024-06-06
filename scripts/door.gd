extends Node

class_name Door

@export var open := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var opened_out := false

signal DoorOpened
signal DoorClosed

func _ready() -> void:
	animation_player.play("RESET")

func interact():
	if open:
		close_door()
	else:
		open_door()
		
func open_door():
	animation_player.play("open")
	open = true
	DoorOpened.emit()
	
func open_door_out():
	animation_player.play("open_out")
	open = true
	opened_out = true
	DoorOpened.emit()
	
func close_door():
	animation_player.play("open_out" if opened_out else "open", -1, -1, true)
	open = false
	opened_out = false
	DoorClosed.emit()
	
