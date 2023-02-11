extends Position2D

export(PackedScene) var mob
export var spawn_rate :int


func _ready() -> void:
	$Speed.wait_time = spawn_rate
	$Speed.start()

func spawn():
	var spawned_unit = mob.instance()
	add_child(spawned_unit)
	print("Spawned")



func _on_Speed_timeout() -> void:
	spawn()
