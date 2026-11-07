extends CharacterBody2D

@export var hitbox:CollisionShape2D

func _physics_process(delta: float) -> void:
	
	move_and_slide()

func on_collision():
	
