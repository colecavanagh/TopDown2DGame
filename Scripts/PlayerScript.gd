extends CharacterBody2D

@export var FRICTION: int = 200
@export var ACCEL: int = 100
@export var MAX_SPEED: int = 15
@export var KNOCKBACK: float = 1.2

signal bullet_fired(bullet: Bullet, position, direction)
signal update_health_ui(new_health: int)
signal update_ammo_ui(new_count: int)

@export var bullet: PackedScene = preload("res://Scenes/Actors/Bullet.tscn")
@onready var muzzle = $Muzzle
@onready var barrel = $Barrel
var health: int = 3
@export var ammo_count: int = 6


func _ready():
	update_ammo_ui.emit(ammo_count)


func _physics_process(delta):
	#move player
	var direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	direction = direction.normalized()
	if(direction != Vector2.ZERO):
		velocity = velocity.move_toward(MAX_SPEED * direction, ACCEL * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_collide(velocity)
	
	#point player towards mouse
	look_at(get_global_mouse_position())


func _unhandled_input(event):
	if(event.is_action_pressed("mouse_click_left")):
		shoot()

func shoot():
	if(ammo_count > 0):
		var bullet_instance = bullet.instantiate()
		var shot_direction = (muzzle.global_position - barrel.global_position).normalized()
		bullet_fired.emit(bullet_instance, muzzle.global_position, shot_direction)
		ammo_count -= 1
		update_ammo_ui.emit(ammo_count)


func knockback(body: PhysicsBody2D):
	var knockback_direction = self.global_position - body.global_position
	move_and_collide(knockback_direction * KNOCKBACK)


func add_ammo(amt: int):
	ammo_count += amt
	update_ammo_ui.emit(ammo_count)


func add_health(amt: int):
	health += amt
	update_health_ui.emit(health)

func _on_hurtbox_body_entered(body):
	if(body.is_in_group("enemy")):
		knockback(body)
		health -= 1
		update_health_ui.emit(health)
		if(health <= 0):
			get_tree().change_scene_to_file("res://Scenes/Menus/GameOverMenu.tscn")
