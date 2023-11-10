extends Control

var card_scene = preload("res://Things/card.tscn")

func _ready():
	for i in range(10):
		create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/1", i)



func _process(delta):
	pass


func _on_leave_pressed():
	get_tree().quit()

func create_card(object , i):
	var card = card_scene.instantiate()
	card.text = "Note" + str(i)
	card.date = "10 Nov, 2023"
	object.add_child(card)
