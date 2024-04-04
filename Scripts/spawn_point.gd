extends Node2D

@onready var enemy_scene = preload("res://Scenes/Actors/Enemy.tscn")


func spawn_enemy():
	var instance = enemy_scene.instantiate()
	instance.position = self.position
	get_parent().get_node("EnemyHandler").call_deferred("add_child", instance)
