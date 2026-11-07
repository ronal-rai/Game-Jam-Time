extends CharacterBody2D
class_name Player

@export var device: int


const ACCELERATION: float = 50
const MAX_SPEED: float = 900
const DECELERATION: float = 90

const DEADZONE: float = 0.08
const AIM_DEADZONE: float = 0.25

var direction: Vector2
var directionAiming: Vector2
var equip: weapon

# Reads the right stick and returns a vector (length 0..1).
# Returns Vector2.ZERO when the stick is inside the deadzone.
func read_aim_stick() -> Vector2:
	var stick := Vector2(
		Input.get_joy_axis(device, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(device, JOY_AXIS_RIGHT_Y))
	if stick.length() < AIM_DEADZONE:
		return Vector2.ZERO
	return stick.limit_length(1.0)


# Public getter: returns the current aim direction as a unit vector.
func get_aim_direction() -> Vector2:
	return directionAiming

# updates the aiming
func updateAiming() -> void:
	var stick := read_aim_stick()
	if stick != Vector2.ZERO:
		directionAiming = stick.normalized()


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
	direction = direction.limit_length(1.0)
	applyDeadzone()
	
	updateAiming()
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

# updates velocity
	if direction != Vector2.ZERO:
		# Accelerate toward the target velocity (direction * max speed)
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	else:
		# Slow down to a stop
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION)
	
	

	move_and_slide()

func attack():
	print("attacked")
