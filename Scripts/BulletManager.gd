extends Node2D

@onready var player = get_node("/root/Main/Player")


func _ready():
	player.bullet_fired.connect(handle_bullet)

func handle_bullet(bullet: Bullet, bullet_position, direction):
	add_child(bullet)
	bullet.position = bullet_position
	bullet.set_direction(direction)
