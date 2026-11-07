extends CanvasLayer

@onready var time_label: Label = $Margin/HBox/TimeLabel

func _ready():
	TimeManager.time_changed.connect(_on_time_changed)
	_on_time_changed(TimeManager.time_left, TimeManager.max_time)

func _on_time_changed(time_left: float, max_time: float):
	time_label.text = "%.1f" % time_left
	time_label.modulate = Color.RED if time_left < 10.0 else Color.WHITE
