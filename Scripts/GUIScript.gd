extends Control

@onready var health_counter = $"VBoxContainer/HBoxContainer/Health Counter/Label"
@onready var ammo_counter = $"VBoxContainer/HBoxContainer/Ammo Counter/Label"
@onready var wave_label = $"VBoxContainer/WaveLabel/Label"
@onready var player = get_node("/root/Main/Player")
@onready var enemy_spawner = get_node("/root/Main/Global Logic/EnemySpawner")

func _ready():
	player.update_health_ui.connect(update_health)
	player.update_ammo_ui.connect(update_ammo)
	enemy_spawner.wave_defeated.connect(update_wave)



func update_health(new_health):
	health_counter.text = str(new_health)


func update_ammo(new_ammo):
	ammo_counter.text = str(new_ammo)

func update_wave(new_wave):
	wave_label.text = "Wave: " + str(new_wave)
