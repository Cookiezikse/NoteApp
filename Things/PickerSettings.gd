extends HBoxContainer

@export var text : String = "Background Color"

enum states {
	background,
	text,
	note,
	other
}

@export var state : states = states.background

func _ready() -> void:
	match state:
		states.background:
			$ColorPickerButton.color = All.hex_background
		states.text:
			$ColorPickerButton.color = All.hex_text
		states.other:
			$ColorPickerButton.color = All.hex_other
		states.note:
			$ColorPickerButton.color = All.hex_notes
	
	$text.text = text
	
	$text.label_settings.font_color = All.hex_text
	$min.label_settings.font_color = All.hex_text


func _process(delta: float) -> void:
	$text.label_settings.font_color = All.hex_text
	$min.label_settings.font_color = All.hex_text


func _on_color_picker_button_color_changed(color: Color) -> void:
	match state:
		states.background:
			All.hex_background = color
		states.text:
			All.hex_text = color
		states.other:
			All.hex_other = color
		states.note:
			All.hex_notes = color
	SaveColors()

func _on_button_pressed() -> void:
	match state:
		states.background:
			All.hex_background = All.hex_background_default
		states.text:
			All.hex_text = All.hex_text_default
		states.other:
			All.hex_other = All.hex_other_default
		states.note:
			All.hex_notes = All.hex_notes_default
	SaveColors()

func SaveColors()->void:
	var data = {"hex_background":All.hex_background,"hex_notes":All.hex_notes,"hex_text":All.hex_text,"hex_other":All.hex_other}
	global.save_json_file(global.file_settings,data)
