extends CharacterBody2D
class_name Player

const ACCELERATION: float = 50
const MAX_SPEED: float = 900
const DECELERATION: float = 90
const DEADZONE: float = 0.08
@export var device: int
var direction: Vector2
	
	

func applyDeadzone():
	if  abs(direction.x) < abs(DEADZONE) or abs(direction.x) > abs(1-DEADZONE):
		direction.x = round(direction.x)
	if  abs(direction.y) < abs(DEADZONE) or abs(direction.y) > abs(1-DEADZONE):
		direction.y = round(direction.y)

func _physics_process(delta: float) -> void:
	# gets controller axis
	direction = Vector2(
	Input.get_joy_axis(device, JOY_AXIS_LEFT_X),
	Input.get_joy_axis(device, JOY_AXIS_LEFT_Y))
	direction.normalized()
	applyDeadzone()
	print(direction)


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

# acellerates and 
	if direction != Vector2.ZERO:
		# Accelerate toward the target velocity (direction * max speed)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	else:
		# Slow down to a stop
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION)
	
	

	move_and_slide()
