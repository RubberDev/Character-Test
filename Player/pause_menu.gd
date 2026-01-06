extends Control

func _ready() -> void:
	$Panel.hide()
	$Settings.hide()
	get_tree().paused = false
	
	$Settings/Panel/vBox1/VolumeSlider.value = db_to_linear(AudioServer.get_bus_volume_db(_bus))

# Resume the game
func _on_resume_pressed() -> void:
	get_tree().paused = false
	$Panel.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Save game
func _on_save_pressed() -> void:
	pass # Replace with function body.

# Load game
func _on_load_pressed() -> void:
	pass # Replace with function body.

# Open settings menu
func _on_settings_pressed() -> void:
	$Settings.show()

# Quit the game
func _on_quit_pressed() -> void:
	get_tree().quit()

# Handle pausing
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Escape"):
		if get_tree().paused == false:
			get_tree().paused = true
			$Panel.show()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif get_tree().paused == true:
			get_tree().paused = false
			$Panel.hide()
			$Settings.hide()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			

# Close settings
func _on_exit_settings_pressed() -> void:
	$Settings.hide()

# Change game volume
@export var Audio_Bus := "Master"
@onready var _bus := AudioServer.get_bus_index(Audio_Bus)

func _on_volume_slider_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(_bus, linear_to_db($Settings/Panel/vBox1/VolumeSlider.value))
	$Settings/Panel/vBox1/Volume.text = "Volume: " + str($Settings/Panel/vBox1/VolumeSlider.value*100)

# Change player sensitivity (Uhh idk how I'm supposed to do this now...)
func _on_sens_slider_value_changed(_value: float) -> void:
	pass

# Change player FOV
func _on_fov_slider_value_changed(_value: float) -> void:
	pass

# Window mode
func _on_screen_types_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Resolutions
func _on_resolution_choices_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1200))
		1:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		2:
			DisplayServer.window_set_size(Vector2i(1440, 900))
		3:
			DisplayServer.window_set_size(Vector2i(1280, 800))
		4:
			DisplayServer.window_set_size(Vector2i(1280, 720))
		5:
			DisplayServer.window_set_size(Vector2i(854, 480))
		6:
			DisplayServer.window_set_size(Vector2i(768, 480))

# Anti-Aliasing
func _on_anti_aliasing_choices_item_selected(index: int) -> void:
	match index:
		0:
			get_viewport().msaa_3d = Viewport.MSAA_8X
		1:
			get_viewport().msaa_3d = Viewport.MSAA_4X
		2:
			get_viewport().msaa_3d = Viewport.MSAA_2X
		3:
			get_viewport().msaa_3d = Viewport.MSAA_DISABLED
		4:
			get_viewport().use_taa = true

# Vsync mode
func _on_vsync_choices_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		1:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
		2:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
