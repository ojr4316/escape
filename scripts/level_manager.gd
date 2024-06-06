extends Node3D


const REPEATING_LEVEL = preload("res://scenes/repeating_level.tscn")

var left_offset = Vector3(0, -5, -60)
var right_offset = Vector3(0, 5, 60)

@onready var start_door = $level/Door/DoorAnimatableBody3D
@onready var end_door = $level/Door2/DoorAnimatableBody3D
@onready var teleport_door = $TeleportDoor
@onready var teleport_door_2 = $TeleportDoor2

@onready var player: CharacterBody3D = $Player

func teleport_player():
	player.global_position -= Vector3(0, 5, 65)
	start_door.open_door_out()
	end_door.close_door()

func teleport_player_back():
	player.global_position += Vector3(0, 5, 65)
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
