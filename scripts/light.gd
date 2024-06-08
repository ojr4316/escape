extends StaticBody3D

@onready var light = $SpotLight3D

func turn_off():
	light.light_energy = 0

func turn_on():
	light.light_energy = 1.6	
