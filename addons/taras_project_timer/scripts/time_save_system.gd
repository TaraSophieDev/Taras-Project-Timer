class_name SaveManager
extends Node

var json = JSON.new()


var user_save_path: String = "res://addons/taras_project_timer/saves/user.save"

func tracker_dictionary(time: float, pause_on_unfocus: bool):
	var tracker_dict: Dictionary = {
		"times": {
			"general": time
		},
		"settings": {
			"pause_on_unfocus": pause_on_unfocus
		}
	}
	return tracker_dict
	
var default_tracker_dict: Dictionary = {
	"times": {
		"general": 0.0
	},
	"settings": {
		"pause_on_unfocus": false
	}
}


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

func save_tracker(time: float, pause_on_unfocus: bool):
	var tracker_file = FileAccess.open(user_save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(tracker_dictionary(time, pause_on_unfocus))
	tracker_file.store_line(json_string)

func load_tracker():
	var json = JSON.new()
	if not FileAccess.file_exists(user_save_path):
		return default_tracker_dict
	
	var loaded_tracker_file = FileAccess.open(user_save_path, FileAccess.READ)
	var content := loaded_tracker_file.get_as_text()
	loaded_tracker_file.close()
	var parsed_data: Error = json.parse(content)
	if parsed_data != OK:
		print("Error %s reading json file." % parsed_data)
		return
	var data: Dictionary = json.get_data()
	return data

func delet_tracker_save():
	if not FileAccess.file_exists(user_save_path):
		return
	DirAccess.remove_absolute(user_save_path)

