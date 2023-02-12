extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	PlayerData.score = 0

func _process(delta: float) -> void:
	$YSort/Player/Score.text = "Score: " + String(PlayerData.score)
