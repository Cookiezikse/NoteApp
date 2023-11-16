extends Control

@onready var colorPicker = $VBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/ColorPickerButton

func _ready():
	pass

func _process(delta):
	pass


func _on_button_pressed():
	colorPicker.color = global.hex_background

func leave():
	#sauvegarder les couleurs etc
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_home_pressed():
	leave()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		leave()
