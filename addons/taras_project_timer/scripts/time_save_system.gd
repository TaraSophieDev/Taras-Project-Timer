class_name SaveManager
extends Node

var json = JSON.new()

var time_save_path: String = "res://addons/taras_project_timer/saves/project-time.save"
var settings_path: String = "res://addons/taras_project_timer/saves/settings.save"

func settings_dict(pause_on_unfocus: bool):
	var settings_dict: Dictionary = {
		"pause_on_unfocus": pause_on_unfocus
	}
	return settings_dict
	
func save_dict(time: float):
	var save_dict: Dictionary = {
		"time": time
	}
	return save_dict

var default_settings_dict: Dictionary = {
		"pause_on_unfocus": false
	}
	
var default_save_dict: Dictionary = {
		"time": 0.0,
	}

func save_time(time: float):
	var save_time = FileAccess.open(time_save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict(time))
	save_time.store_line(json_string)
	
func save_settings(pause_on_unfocus: bool):
	var save_settings = FileAccess.open(settings_path, FileAccess.WRITE)
	var json_string: String = JSON.stringify(settings_dict(pause_on_unfocus))
	save_settings.store_line(json_string)

func load_time():
	var json = JSON.new()
	if not FileAccess.file_exists(time_save_path):
		return default_save_dict
	
	var save_time = FileAccess.open(time_save_path, FileAccess.READ)
	var content := save_time.get_as_text()
	save_time.close()
	var parsed_data: Error = json.parse(content)
	if parsed_data != OK:
		print("Error %s reading json file." % parsed_data)
		return
	var data: Dictionary = json.get_data()
	return data

func load_settings():
	var json = JSON.new()
	if not FileAccess.file_exists(settings_path):
		return default_settings_dict
	
	var save_settings = FileAccess.open(settings_path, FileAccess.READ)
	var content := save_settings.get_as_text()
	save_settings.close()
	var parsed_data: Error = json.parse(content)
	if parsed_data != OK:
		print("Error %s reading json file." % parsed_data)
		return
	var data: Dictionary = json.get_data()
	return data

func delete_time_save(path: String):
	if not FileAccess.file_exists(path):
		return
	DirAccess.remove_absolute(path)
	
