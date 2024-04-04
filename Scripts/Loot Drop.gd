extends Node2D

var rng = RandomNumberGenerator.new()
var loot = null
@onready var health_pickup: PackedScene = preload("res://Scenes/Actors/health_pickup.tscn")
@onready var ammo_pickup: PackedScene = preload("res://Scenes/Actors/ammo_pickup.tscn")


func loot_roll():
	var loot_decision = rng.randi_range(1,10)
	if(loot_decision <=2):
		loot = health_pickup
	elif(loot_decision <= 5):
		loot = ammo_pickup
