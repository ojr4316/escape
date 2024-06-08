extends Node3D

# Was having rotation issues? could probably replace buttt

@onready var door: AnimatableBody3D = $DoorAnimatableBody3D

@export var open := false
@export var locked := true

func _ready():
	door.open = open
	door.locked = locked
