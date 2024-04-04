extends Area2D

class_name Bullet

@export var shot_speed = 1700.0
@onready var bullet_timer = $"Bullet Timer"
var shot_direction = Vector2.ZERO

func _ready():
	bullet_timer.start()

func _physics_process(delta):
	if(shot_direction != Vector2.ZERO):
		var velocity = shot_speed * shot_direction * delta
		global_position += velocity

func set_direction(direction):
	self.shot_direction = direction
	rotation = direction.angle()


func _on_bullet_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if(body.has_method("handle_damage")):
		body.handle_damage(self.global_position)
		queue_free()
