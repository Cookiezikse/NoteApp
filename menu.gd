extends Control

var card_scene = preload("res://Things/card.tscn")
@onready var file = 'res://datas/datas.txt'

var longestId = 0

func _ready(): #Chercher un système d'id
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
