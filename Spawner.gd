extends Position2D

export(PackedScene) var bat
export(PackedScene) var gbat
export var spawn_rate :int
export var rare_spawn_rate :int


func _ready() -> void:
	$Speed.wait_time = spawn_rate
	$Speed.start()
	randomize()
	if rare_spawn_rate > 100:
		rare_spawn_rate = 100
	if rare_spawn_rate <= 0:
		rare_spawn_rate = 1

func spawn():
	var spawned_unit
	var sp = randi() % (100 / rare_spawn_rate)
	if sp == 0:
		spawned_unit = gbat.instance()
	else:
		spawned_unit = bat.instance()
	add_child(spawned_unit)
	print("Spawned")



func _on_Speed_timeout() -> void:
	spawn()
