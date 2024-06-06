extends Area3D

func get_interactable():
	var list = get_overlapping_areas()
	if list.size() > 0:
		for i in list:
			if i.is_in_group("interactable"):
				return i.get_parent()
	return null
