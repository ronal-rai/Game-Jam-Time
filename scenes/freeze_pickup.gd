extends Pickup

@export var duration := 3.0

func apply(player: Node2D) -> void:
	TimeManager.apply_time_effect(0.0, duration)
