extends Entity
class_name Enemy

signal EnemyDeath(TimeRechage: float)

var TimeRechage: float
var Health: float

func _init(setHealth: float,setTimeRechage:float) -> void:
	TimeRechage =setTimeRechage
	Health = setHealth

func Hit(Damage:float):
	Health -= Damage
	if Health < 0:
		Death()

func Death():
	EnemyDeath.emit()
