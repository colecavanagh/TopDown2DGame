extends CharacterBody2D

var health: int = 100
var rng = RandomNumberGenerator.new()

@onready var ai = $"Enemy AI"
@onready var loot_drop = $"Loot Drop"
@onready var spawner = get_tree().get_first_node_in_group("spawner")


func _ready():
	ai.initialize(self)


func handle_damage(position: Vector2):
	health -= 50
	if(health <= 0):
		enemy_die()


func enemy_die():
	queue_free()
	spawner.current_enemies -= 1
	spawner.check_current_enemies()
	loot_drop.loot_roll()
	if(loot_drop.loot != null):
		var instance = loot_drop.loot.instantiate()
		instance.position = self.position
		get_parent().call_deferred("add_child", instance)

