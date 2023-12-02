class_name SaveManager
extends Node

var time_save_path: String = "user://project-time.save"
var settings_path: String = "user://settings.save"

func settings_dict(pause_without_focus: bool):
	var settings_dict: Dictionary = {
		"pause_without_focus": pause_without_focus,
	}
	
func save_dict(time: float, save_path: String):
	var save_dict: Dictionary = {
		"time": time,
		"save_path": save_path
	}

func save_time(time: float, path: String):
	var save_time = FileAccess.open(path, FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict(time, path))
	save_time.store_fline(json_string)
	
func save_settings(pause_without_focus: bool):
	var save_settings = FileAccess.open(settings_path, FileAccess.WRITE)
	var json_string = JSON.stringify(settings_dict(pause_without_focus))
	save_settings.store_line(json_string)

func load_time(path: String):
	if not FileAccess.file_exists(path):
		return 0.0
	
	var save_time = FileAccess.open(path, FileAccess.READ)
	var content := save_time.get_as_text()
	save_time.close()
	var data: Dictionary = JSON.parse_string(content)
	return data

func load_settings():
	if not FileAccess.file_exists(settings_path):
		return 0.0
	
	var save_settings = FileAccess.open(settings_path, FileAccess.READ)
	var content := save_settings.get_as_text()
	save_settings.close()
	var data: Dictionary = JSON.parse_string(content)
	return data

func delete_time_save(path: String):
	if not FileAccess.file_exists(path):
		return
	DirAccess.remove_absolute(path)
	
