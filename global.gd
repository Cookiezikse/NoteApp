extends Node

var id_clicked = null
var lastId = 0

var color_notes = Color(14,14,14,255)
var color_background = Color(18,18,18,255)

func load_json_file(filepath: String):
	if FileAccess.file_exists(filepath):
		var dataFile = FileAccess.open(filepath,FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			dataFile.close()
			return parsedResult
		else:
			print("Error reading file")
		dataFile.close()
	else:
		print("File doesn't exist !")

func save_note_json_file(filepath: String,parsedResult ,data):
	if FileAccess.file_exists(filepath):
		var dataFile = FileAccess.open(filepath,FileAccess.WRITE)
		if !parsedResult.has("note" + str(global.id_clicked)):
			parsedResult["note" + str(parsedResult.size())] = data
		else:
			parsedResult["note" + str(global.id_clicked)] = data
		var json_data = JSON.stringify(parsedResult)
		dataFile.store_string(json_data)
		dataFile.close()
	else:
		print("File doesn't exist !")
		
func save_json_file(filepath: String,parsedResult):
	if FileAccess.file_exists(filepath):
		var dataFile = FileAccess.open(filepath,FileAccess.WRITE)
		var json_data = JSON.stringify(parsedResult)
		dataFile.store_string(json_data)
		dataFile.close()
	else:
		print("File doesn't exist !")

func delete_note_json_file(parsedResult):
	if parsedResult.has("note"+str(global.id_clicked)):
		parsedResult.erase("note"+str(global.id_clicked))


			#parsedResult["note" + str(global.id_clicked)] = data
			#var notex = parsedResult["note"+ str(global.id_clicked)]
			#notex["text"] = data["text"]
			#notex["id"] = data["id"]

func ancien_save_note_json_file(filepath: String,parsedResult ,data):
	if FileAccess.file_exists(filepath):
		var dataFile = FileAccess.open(filepath,FileAccess.WRITE)
		print(parsedResult)
		if !parsedResult.has("note" + str(global.id_clicked)):
			parsedResult["note" + str(parsedResult.size())] = data
		else:
			var list = []
			print("parsed size : ",parsedResult.size())
			for i in parsedResult.size():
				if i != id_clicked:
					list.append(parsedResult["note"+str(i)])
					print(parsedResult["note"+str(i)])
			list.append(data)
			parsedResult.clear()
			print("list size : ",list.size())
			for i in list.size():
				print(list[i])
				parsedResult["note"+str(i)] = list[i]

		var json_data = JSON.stringify(parsedResult)
		dataFile.store_string(json_data)
		dataFile.close()
	else:
		print("File doesn't exist !")
