extends Area2D

class_name HealthPickup

func _on_body_entered(body):
	if(body.is_in_group("player")):
		body.add_health(1)
		queue_free()
