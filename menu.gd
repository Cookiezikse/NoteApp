extends Control

var card_scene = preload("res://Things/card.tscn")
@onready var file = 'datas/datas.json' # ça arrive pas a y acceder quand on a le .exe, voir les solutions à avoir

var longestId = 0


#Does the screen with all the notes 
func _ready():
	var datas = global.load_json_file(file)
	global.id_clicked = null
	var index = 0
	index = datas.size()
	longestId = index
	global.lastId = longestId
	var count = 0 
	
	#print(datas)
	
	while count < index:
		#while true:
		#	if datas.has("note" + str(count)):
		#		create_card_json($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/2",count,datas["note" + str(count)])
		#	else:
		#		count +=1
		
		
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
	card.date = "10 Nov, 2023"
	card.id = count
	object.add_child(card)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://note.tscn")
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_pressed():
	get_tree().change_scene_to_file("res://note.tscn")

func _on_new_note_pressed():
	get_tree().change_scene_to_file("res://note.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://settings.tscn")






func create_card(object , i):
	var card = card_scene.instantiate()
	
	var line = ""
	var f = FileAccess.open("datas/datas.txt",FileAccess.READ)
	var index = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		if index == i:
			line = f.get_line()
			break;
		index+=1
		f.get_line()
	f.close()
	if !line:
		line = "Error/NoData"

	card.text = line
	card.date = "10 Nov, 2023"
	card.id = i
	object.add_child(card)


func ancien_ready(): #Chercher un système d'id
	#for i in range(10):
	#	create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/1", i)
	#	create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/2", i+100)
	#	create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/3", i+1000)
	#	create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/4", i+10000)
	#	create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/5", i+100000)
	
	global.id_clicked = null
	var f = FileAccess.open("datas/datas.txt",FileAccess.READ)
	var index = 0
	while not f.eof_reached(): # iterate through all lines until the end of file is reached
		index+=1
		
		f.get_line()
	f.close()
	var data = load("res://datas/datas.json")
	longestId = index - 1
	global.lastId = longestId
	var count = 0 
	while count < index:
		if count < longestId:
			create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/1",count)
		count +=1
		if count < longestId:
			create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/2",count)
		count +=1
		if count < longestId:
			create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/3",count)
		count +=1
		if count < longestId:
			create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/4",count)
		count +=1
		if count < longestId:
			create_card($"Pages/Home/VBoxContainer/ScrollContainer/VBoxContainer/HBoxContainer/5",count)
		count += 1

