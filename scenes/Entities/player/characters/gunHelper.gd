extends Node2D

var ownerEntity: Entity

@onready var sheriff: PlayerRanged = $".."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position = sheriff.get_aim_direction()*80
	
	print(position.x)
	if position.x <= 0:
		scale = Vector2(-1,1)
	else:
		scale = Vector2(1,1)
		
	rotation = position.angle()
