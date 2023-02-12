extends KinematicBody2D

enum {AGGRO, PASSIVE}
var _state
export var exploration_interval :int
export var speed :int
const exploration_limit = 50
var target_location :Vector2
export var detect_player:int
var player


#signal kill_score(value)
var score = 1


"""
AI Logic:
	* Bat has two modes: aggro and passive
	* Bat when spawned would have passive mode by default
	* In passive mode it would try to find a random location and then approach that
	* If a player enter in a targetable area it would turn aggro
	* If bat turns aggro it would go straight to the player and clash with her
"""

func _ready() -> void:
	$AnimationPlayer.play("Idle")
	_state = PASSIVE
	$Explore.wait_time = exploration_interval
	$Explore.start()
	target_location = position

func _process(delta: float) -> void:
	if player:
		position = position.move_toward(player.position, speed*delta)
	else:
		position = position.move_toward(target_location, speed*delta)


func look_for_player(playerPos :Vector2) -> void:
	if (playerPos - position).length() < detect_player:
		_state = AGGRO

func create_dead_effect():
	var HitEffect = load("res://Scenes/Hit_effect.tscn")
	var hitEffect = HitEffect.instance()
	var level = get_tree().current_scene
	level.add_child(hitEffect)
	hitEffect.global_position = global_position



func _on_Explore_timeout():
	target_location = Vector2(rand_range(-exploration_limit, exploration_limit), rand_range(-exploration_limit, exploration_limit))
	if $Sprite.flip_h == false and target_location.x < 0:
		$Sprite.flip_h = true
	if $Sprite.flip_h == true and target_location.x > 0:
		$Sprite.flip_h = false
	target_location += position
	print(target_location)


func _on_Hurtbox_area_entered(area):
	create_dead_effect()
	queue_free()

func set_score(new_score: int):
	score = new_score
	

func _on_Bat_tree_exited():
	PlayerData.score += 1
	#emit_signal("kill_score",1)
