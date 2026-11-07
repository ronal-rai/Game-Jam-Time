extends Node2D

@onready var sir_knight: PlayerMelee = $".."
const HoldDistance: float = 80

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#position = sir_knight.get_aim_direction()*HoldDistance
	
	print(position.x)
	if sir_knight.get_aim_direction().x <= 0:
		position.x = -HoldDistance
		scale = Vector2(-1,1)
	else:
		position.x = HoldDistance
		scale = Vector2(1,1)
		
