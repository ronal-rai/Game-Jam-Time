extends Area2D
class_name Pickup

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("players"):
		return
	apply(body)
	_collect()

# Each pickup type overrides this
func apply(Player: Node2D) -> void:
	pass

func _collect():
	set_deferred("monitoring", false)
	$Sprite.visible = false
	$Shadow.visible = false
	$PickupSound.play()
	await $PickupSound.finished
	queue_free()
