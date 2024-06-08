extends Node3D

@export var text = "736"
@onready var label: Label3D = $Label3D

func _ready():
	label.text = text
