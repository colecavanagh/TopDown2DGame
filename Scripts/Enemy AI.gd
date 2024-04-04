extends Node2D


@export var approach_speed: float = 300.0

var current_state: int = State.IDLE
var enemy_instance = null
var player = null

enum State{
	IDLE,
	APPROACH
}

func initialize(actor):
	self.enemy_instance = actor

func _physics_process(delta):
	match current_state:
		State.IDLE:
			pass
		State.APPROACH:
			var approach_direction = (player.global_position - enemy_instance.global_position).normalized()
			enemy_instance.look_at(player.global_position)
			enemy_instance.move_and_collide(approach_direction * approach_speed * delta)
		_:
			print("enemy entered unknown state")

func set_state(new_state: int):
	if(new_state == current_state):
			return
	else:
		current_state = new_state


func _on_detection_zone_body_entered(body):
	if(body.is_in_group("player")):
		set_state(State.APPROACH)
		player = body


func _on_detection_zone_body_exited(body):
	if(body.is_in_group("player")):
		set_state(State.IDLE)
		player = body
