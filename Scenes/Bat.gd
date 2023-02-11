extends KinematicBody2D

enum {AGGRO, PASSIVE}
var _state
export var exploration_interval :int
export var speed :int
const exploration_limit = 50
var target_location :Vector2
export var detect_player:int

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
	position = position.move_toward(target_location, speed*delta)


func _on_Explore_timeout() -> void:
	target_location = Vector2(rand_range(-exploration_limit, exploration_limit), rand_range(-exploration_limit, exploration_limit))
	if $Sprite.flip_h == false and target_location.x < 0:
		$Sprite.flip_h = true
	if $Sprite.flip_h == true and target_location.x > 0:
		$Sprite.flip_h = false
	target_location += position

func look_for_player(playerPos :Vector2) -> void:
	if (playerPos - position).length() < detect_player:
		_state = AGGRO


func _on_Area2D_body_entered(body: Node) -> void:
	$Explore.stop()
	print("Entered!")
	target_location = body.position
