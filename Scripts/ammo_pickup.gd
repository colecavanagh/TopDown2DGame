extends Area2D

class_name AmmoPickup

func _on_body_entered(body):
	if(body.is_in_group("player")):
		body.add_ammo(5)
		queue_free()
