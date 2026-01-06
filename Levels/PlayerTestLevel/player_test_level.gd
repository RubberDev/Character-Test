extends Node3D

var Side_Cam_Enabled : bool = false

func _on_button_pressed() -> void:
	if Side_Cam_Enabled == false:
		Side_Cam_Enabled = true
		$SideView.make_current()
	elif Side_Cam_Enabled == true:
		Side_Cam_Enabled = false
		$Player/PlyrCamera3D.make_current()
