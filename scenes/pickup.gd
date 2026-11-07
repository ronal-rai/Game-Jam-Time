extends Area2D

enum Type { HOURGLASS, POCKET_WATCH, FROZEN_CLOCK, MOLASSES }

@export var type: Type = Type.HOURGLASS
@export var amount := 5.0  # seconds of time, or effect duration

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("players"):
		return

	match type:
		Type.HOURGLASS, Type.POCKET_WATCH:
			body.add_time(amount)
		Type.FROZEN_CLOCK:
			body.freeze_timer(amount)
		Type.MOLASSES:
			get_tree().call_group("enemies", "set_time_scale", 0.4, amount)

	_collect()

func _collect():
	# Hide it and stop more collisions, but let the sound finish
	set_deferred("monitoring", false)
	$Sprite.visible = false
	$Shadow.visible = false
	$PickupSound.play()
	await $PickupSound.finished
	queue_free()
