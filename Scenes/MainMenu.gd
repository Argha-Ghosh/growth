extends Control


func _ready() -> void:
	$AudioStreamPlayer.play()


func _on_Button2_pressed() -> void:
	get_tree().quit()


func _on_Button_pressed() -> void:
	get_tree().change_scene("res://Scenes/Level-1_Main Scene.tscn")
	PlayerData.score = 0
