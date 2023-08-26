extends TextEdit

var openFile: String
var fileContents: String
var saveContents: String


func _on_file_dialog_file_selected(path):
	if $FileDialog.file_mode == FileDialog.FILE_MODE_OPEN_FILE:
		openFile = path
		var file = FileAccess.open(path, FileAccess.READ)
		fileContents = file.get_as_text()
		text = fileContents
		file.close()
	else:
		openFile = path
		var file = FileAccess.open(path, FileAccess.WRITE)
		file.store_string(saveContents)
		file.close()

func _on_open_button_pressed():
	$FileDialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	$FileDialog.popup()


func _on_save_button_pressed():
	if openFile.is_empty():
		$FileDialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
		$FileDialog.popup()
		saveContents = text
	else:
		var file = FileAccess.open(openFile, FileAccess.WRITE)
		saveContents = text
		file.store_string(saveContents)
		file.close()


func _on_new_button_pressed():
	if fileContents != text:
		saveContents = text
		$FileDialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
		$FileDialog.popup()
	text = ""
	openFile = ""
