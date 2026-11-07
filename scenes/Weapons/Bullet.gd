extends CharacterBody2D
class_name Bullet

#fix glitch with player hitting other

var ownerEntity: Entity


@export var hitbox:CollisionShape2D

func _init(Direction:Vector2,Speed: float,onwner :Entity) -> void:
	velocity = Direction*Speed
	ownerEntity = owner


func _physics_process(delta: float) -> void:
	
	var collision := move_and_collide(velocity * delta)
	if collision:
		var body := collision.get_collider()
		on_collision(body)


func on_collision(body:PhysicsBody2D):
	if body == ownerEntity:
		return
	elif body is Entity:
		body.Damage()
	else:
		queue_free()
	
