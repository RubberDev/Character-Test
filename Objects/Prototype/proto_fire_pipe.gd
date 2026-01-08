extends Node3D

@export var TimerTime = 3.0
@export var Active : bool = false

func _ready() -> void:
	$FireTimer.set_deferred("wait_time", TimerTime)
	if Active == false:
		Active = true
		Laser_Fire()
	elif Active == true:
		Active = false
		Laser_Dormant()

func _on_timer_timeout() -> void:
	if Active == false:
		Active = true
		Laser_Fire()
	elif Active == true:
		Active = false
		Laser_Dormant()


func Laser_Dormant():
	$Laser.hide()

func Laser_Fire():
	$Laser.show()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		if Active == true:
			get_tree().reload_current_scene()
