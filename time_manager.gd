extends Node

signal time_changed(time_left, max_time)
signal score_changed(score, multiplier)
signal time_ran_out

@export var player1: Node2D
@export var player2: Node2D

@export var max_time := 60.0         # seconds of "life"
@export var base_drain := 1.0        # seconds lost per second when together
@export var extra_drain := 3.0       # extra drain at max spread
@export var max_distance := 600.0    # pixels apart where spread is maxed
@export var max_multiplier := 5.0

var time_left := 0.0
var score := 0.0
var multiplier := 1.0

var drain_scale := 1.0
var effect_remaining := 0.0

func _ready():
	time_left = max_time

func _process(delta):
	if time_left <= 0.0:
		return

	var dist := player1.global_position.distance_to(player2.global_position)
	var spread := clampf(dist / max_distance, 0.0, 1.0)

	var drain := base_drain + extra_drain * spread
	multiplier = lerpf(1.0, max_multiplier, spread)

	if effect_remaining > 0.0:
		effect_remaining -= delta
		drain *= drain_scale
		if effect_remaining <= 0.0:
			drain_scale = 1.0

	time_left -= drain * delta
	score += 10.0 * multiplier * delta

	time_changed.emit(time_left, max_time)
	score_changed.emit(score, multiplier)

	if time_left <= 0.0:
		time_left = 0.0
		time_ran_out.emit()

func apply_time_effect(effect_scale: float, duration: float):
	drain_scale = effect_scale
	effect_remaining = duration

func add_time(amount: float):
	time_left = minf(time_left + amount, max_time)

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F:
			apply_time_effect(0.0, 3.0)
		if event.keycode == KEY_G:
			apply_time_effect(0.5, 5.0)
