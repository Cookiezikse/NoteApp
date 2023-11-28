extends Control

var card_scene = preload("res://Things/card.tscn")
var shortcuts_scene = preload("res://Things/shortcuts_window.tscn")
@onready var file = 'datas/datas.json'

var longestId = 0
#Faire un petit popup quand y a une erreur
#En mode "Le popup est déja présent"

#Faire aussi un truc de pinned ? Met en haut la note qui est pinned
@onready var _MainWindow: Window = get_window()
#Does the screen with all the notes 
func _ready():
	_MainWindow.gui_embed_subwindows = false # Make subwindows actual system windows <- VERY IMPORTANT
	#var time = Time.get_datetime_dict_from_system()
	#print(time["day"]," ",time["month"], " ",time["year"])
	var datas = global.load_json_file(file)
	global.id_clicked = null
	var index = 0
	index = datas.size()
	longestId = index
	global.lastId = longestId
	var count = 0 
	while count < index:
		while !datas.has("note" + str(count)):
			count +=1
			if count > index:
				break
		if datas.has("note" + str(count)):
			create_card_json($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/1",count,datas["note" + str(count)])
		count += 1
		while !datas.has("note" + str(count)):
			count +=1
			if count > index:
				break
		if datas.has("note" + str(count)):
			create_card_json($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/2",count,datas["note" + str(count)])
		count += 1
		while !datas.has("note" + str(count)):
			count +=1
			if count > index:
				break
		if datas.has("note" + str(count)):
			create_card_json($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/3",count,datas["note" + str(count)])
		count += 1

#Create a card with its own text and id
func create_card_json(object , count ,data):
	var card = card_scene.instantiate()
	#print(count)
	card.text = data["text"]
	card.date = data["date"]
	card.id = data["id"]
	object.add_child(card)

#var container_choose = 1
#var container_card = 0

#func container(i:int):
#	var list_containers = [
#		$"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/1",
#		$"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/2",
#		$"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/3"
#	]
#	return list_containers[i+1]

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var newNoteAnimation = $Pages/Home/VBoxContainer/Header/HBoxContainer/newNote/AnimationPlayer
		newNoteAnimation.play("animation")
		await newNoteAnimation.animation_finished
		get_tree().change_scene_to_file("res://note.tscn")
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_up"):
		#container(container_choose).grab_focus()
		pass
	if event.is_action_pressed("ui_down"):
		pass

func _on_new_note_pressed():
	var newNoteAnimation = $Pages/Home/VBoxContainer/Header/HBoxContainer/newNote/AnimationPlayer
	newNoteAnimation.play("animation")
	await newNoteAnimation.animation_finished
	get_tree().change_scene_to_file("res://note.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_help_pressed():
	if $Popups.get_child_count() <= 0:
		var shortcuts = shortcuts_scene.instantiate()
		$Popups.add_child(shortcuts)
