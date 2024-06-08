extends Node3D


const REPEATING_LEVEL = preload("res://scenes/repeating_level.tscn")

var left_offset = Vector3(0, -5, -60)
var right_offset = Vector3(0, 5, 60)

@onready var start_door = $level/EntryDoor/DoorAnimatableBody3D
@onready var end_door = $level/ExitDoor/DoorAnimatableBody3D
@onready var teleport_door = $TeleportDoor
@onready var teleport_door_2 = $TeleportDoor2

@onready var light_1 = $"level/lights/1"
@onready var light_2 = $"level/lights/2"
@onready var light_3 = $"level/lights/3"
@onready var light_4 = $"level/lights/4"

@onready var player: CharacterBody3D = $Player
@onready var timer: Timer = $Timer


var event_idx = 0
func timed_events():
	match (event_idx % 4):
		0:
			light_2.turn_off()
		1:
			light_3.turn_off()
		2:
			light_3.turn_on()
		3:
			light_2.turn_on()
	event_idx+=1
		


func teleport_player():
	player.global_position -= Vector3(0, 5, 65)
	#player.show_overlay()
	start_door.open_door_out()
	end_door.close_door()

func teleport_player_back():
	player.global_position += Vector3(0, 5, 65)
	#player.show_overlay()
	end_door.open_door_out()
	start_door.close_door()

func enter_end():
	start_door.close_door() # prepare, will be changed cause should auto shut

func enter_start():
	end_door.close_door()

func _ready():
	start_door.open_door()
	teleport_door.DoorClicked.connect(teleport_player)
	teleport_door_2.DoorClicked.connect(teleport_player_back)
	
	end_door.DoorOpened.connect(enter_end)
	start_door.DoorOpened.connect(enter_start)
	
	timer.timeout.connect(timed_events)
	
	light_3.turn_off()
