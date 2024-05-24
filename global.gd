extends Node

class_name All

var id_clicked = null
var lastId = 0

static var hex_background_default : Color = Color("#181818")
static var hex_notes_default : Color = Color("#141414")
static var hex_text_default : Color = Color("#ffffff")
static var hex_other_default : Color = Color("#212121")

static var hex_background : Color = Color("#181818")
static var hex_notes : Color = Color("#141414")
static var hex_text : Color = Color("#ffffff")
static var hex_other : Color = Color("#212121")

var file = ""
var file_settings = ""

func ColorFromString(string:String)-> Color:
	var color : Color = Color.BLACK
	var string_float : String
	
	var ListFloats : Array[float]
	
	for i:int in range(string.length()):
		if i <= 0:
			i+=1
		for j:int in range(string.length()):
			if (string[j] == ","):
				string_float = string.get_slicec(i,j-1)
				#print(string_float)
				ListFloats.append(string_float.to_float())
				i = j+1
				break
			if (string[j] == ")"):
				string_float = string.get_slicec(i,j-1)
				ListFloats.append(string_float.to_float())
				break
		
	color.r = ListFloats[0]
	color.g = ListFloats[1]
	color.b = ListFloats[2]
	color.a = ListFloats[3]
	
	#print(ListFloats)
	
	return color

func ColorFromStringNew(string:String)-> Color:
	var color : Color = Color.BLACK
	var string_float : String
	
	var ListFloats : Array[float]
	
	string[0] = " "
	string[string.length()-1] = " "
	#string.erase(string.find("("),0)
	#string.erase(string.find(")"),0)
	#print(string)
	
	var some_string = "One,Two,Three,Four"
	var some_array = string.rsplit(",", true, 3)

	#some_array[0].erase(some_array[0].find("("),1)
	#some_array[some_array.size()-1].erase(some_array[0].find(")"),0)
	
	some_array[0][0]= ""
	some_array[1][0]= ""
	some_array[2][0]= ""
	some_array[3][0]= ""
	some_array[3][1]= ""
	
	print(some_array)
	
	color.r = some_array[0].to_float()
	color.g = some_array[1].to_float()
	color.b = some_array[2].to_float()
	color.a = some_array[3].to_float()
	
	return Color(some_array[0].to_float(),some_array[1].to_float(),some_array[2].to_float(),1)


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
	var f = FileAccess.open(OS.get_user_data_dir()+"/NewFile.md",FileAccess.WRITE)
	f.close()
	#print("ALLO ?")
	#print(OS.get_user_data_dir())
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
		#print(parsedResult)
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
