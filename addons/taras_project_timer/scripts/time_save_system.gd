class_name SaveManager
extends Node

var time_save_path: String = "user://project-time.save"
var settings_path: String = "user://settings.save"

func save_time(time: float, path: String):
	var save_time = FileAccess.open(path, FileAccess.WRITE)
	#var json = JSON.stringify(save_time())
	save_time.store_float(time)
	
func save_settings(settings: bool, path: String):
	var save_settings = FileAccess.open(path, FileAccess.WRITE)
	if settings:
		save_settings.store_8(1)
	else:
		save_settings.store_8(0)

func load_time(path: String):
	if not FileAccess.file_exists(path):
		return 0.0
	
	var save_time = FileAccess.open(path, FileAccess.READ)
	var time: float = save_time.get_float()
	save_time.close()
	return time

func load_settings(path: String):
	if not FileAccess.file_exists(path):
		return 0.0
	
	var save_settings = FileAccess.open(path, FileAccess.READ)
	var settings: bool = bool(save_settings.get_8())
	save_settings.close()
	return settings

func delete_time_save(path: String):
	if not FileAccess.file_exists(path):
		return
	DirAccess.remove_absolute(path)
	
