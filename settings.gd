extends Control

func _ready():
	pass

func _process(delta):
	$VBoxContainer/Header/HBoxContainer/home.add_theme_color_override("font_color", All.hex_text)

func leave():
	#sauvegarder les couleurs etc
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_home_pressed():
	leave()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		leave()

func ChangeHexBackground():
	pass
