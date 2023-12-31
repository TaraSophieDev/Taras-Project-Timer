@tool
extends PanelContainer

var _save_manager = SaveManager.new()

var current_save_path: String
var current_settings_path: String

var time_started: bool = false
var pause_on_unfocus: bool = false
var is_focused: bool = false
var time: float = 0.0
var render_timeout: float = 1.0

func convert_time_to_readable():
	var seconds:int = ((int(time) % 86400) % 3600) % 60
	var minutes: int = ((int(time) % 86400) % 3600) / 60
	var hours: int = (int(time) % 86400) / 3600
	var days: int = int(time) / 86400
	var translated_time = "%02d:%02d:%02d:%02d" % [days ,hours, minutes, seconds]
	
	$VBoxContainer/TimeLabel.text = "" + str(translated_time)
	
func reset_time():
	time_started = false
	time = 0.0

func _ready():
	time_started = true
	is_focused = true
	$VBoxContainer/HBoxContainer/FocusCheckBox.button_pressed = pause_on_unfocus


func _process(delta):
	if time_started and (not pause_on_unfocus or pause_on_unfocus and is_focused):
		time += delta
	render_timeout -= delta
	if render_timeout < 0.0:
		convert_time_to_readable()
		render_timeout = 1.0


func _on_start_button_pressed():
	time_started = true
	pass


func _on_stop_button_pressed():
	time_started = false
	_save_manager.save_tracker(time, pause_on_unfocus)


func _on_reset_button_pressed():
	reset_time()
	_save_manager.delet_tracker_save()


func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		is_focused = true
	elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		is_focused = false
	elif what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_manager.save_tracker(time, pause_on_unfocus)
	elif what == NOTIFICATION_ENTER_TREE:
		time = _save_manager.load_tracker()["times"]["general"]
		pause_on_unfocus = _save_manager.load_tracker()["settings"]["pause_on_unfocus"]
		


func _on_focus_check_box_toggled(toggled_on):
	pause_on_unfocus = toggled_on
	_save_manager.save_tracker(time, pause_on_unfocus)
