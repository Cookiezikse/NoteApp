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
			return parsedResult
		else:
			print("Error reading file")
		dataFile.close()
	else:
		print("File doesn't exist !")


func save_note_json_file(filepath: String, data):
	if FileAccess.file_exists(filepath):
		var dataFile = FileAccess.open(filepath,FileAccess.READ_WRITE)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if !parsedResult.has("note" + str(global.id_clicked)):
			parsedResult["note" + str(parsedResult.size()-1)] = data
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
			#parsedResult["note" + str(global.id_clicked)].clear()
			#parsedResult["note"+  str(global.id_clicked)].clear()
			#clear note i et remplacer tout le truc avec data
			#var parsedData = JSON.stringify(data)
			#var pasedsedData = JSON.parse_string(parsedData)
			#var notex = parsedResult["note"+ str(global.id_clicked)]
			#var json_data_dic = JSON.parse_string(data)
			#notex["text"] = pasedsedData["text"]
			#notex["id"] = pasedsedData["id"]
			#parsedResult["note" + str(global.id_clicked)] = data

		var json_data = JSON.stringify(parsedResult)
		dataFile.store_string(json_data)
		dataFile.close()
	else:
		print("File doesn't exist !")
