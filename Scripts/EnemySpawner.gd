extends Node2D
class_name EnemySpawner

@onready var spawn_array = [
	$SP1, $SP2, $SP3, $SP4, $SP5, $SP6, $SP7, $SP8,
	$SP9, $SP10, $SP11, $SP12, $SP13, $SP14, $SP15, $SP16,
	$SP17, $SP18, $SP19, $SP20, $SP21, $SP22, $SP23, $SP24,
	$SP25, $SP26, $SP27, $SP28, $SP29, $SP30, $SP31, $SP32,
	$SP33, $SP34, $SP35, $SP36, $SP37, $SP38, $SP39, $SP40,
]
@onready var enemy_handler = $EnemyHandler

var wave: int = 1
var enemy_constant: int = 8
var rng = RandomNumberGenerator.new()
var spawn_point_check: Dictionary = {}
var current_enemies: int = 0

signal wave_defeated(new_wave)


func _ready():
	for i in spawn_array:
		spawn_point_check[i] = false
	spawn_current_wave()


func generate_wave(current_wave: int):
	var wave_capital: float = pow((1 + .085), current_wave)
	wave_capital = int(wave_capital * enemy_constant)
	return wave_capital


func choose_spawn_point():
	var determinant = rng.randi_range(0,spawn_array.size() - 1)
	return determinant


func spawn_current_wave():
	print("spawning wave")
	var capital = generate_wave(wave)
	for i in capital:
		var index = choose_spawn_point()
		while(spawn_point_check[spawn_array[index]] == true):
			index = choose_spawn_point()
		spawn_array[index].spawn_enemy()
		spawn_point_check[spawn_array[index]] = true
		current_enemies += 1
		print("spawned enemy at:" + str(index + 1))

func check_current_enemies():
	if(current_enemies == 0):
		next_wave()
		spawn_current_wave()

func next_wave():
	wave += 1
	wave_defeated.emit(wave)
	for i in spawn_point_check:
		spawn_point_check[i] = false
