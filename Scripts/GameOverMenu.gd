extends Control

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_0.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/MainMenu.tscn")
