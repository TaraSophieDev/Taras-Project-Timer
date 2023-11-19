@tool
extends PanelContainer

var _save_manager = SaveManager.new()

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
	time = _save_manager.load_time()
	pass


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
	_save_manager.save_time(time)


func _on_reset_button_pressed():
	reset_time()
	_save_manager.delete_time_save()


func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		is_focused = true
	elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		is_focused = false


func _on_focus_check_box_toggled(toggled_on):
	pause_on_unfocus = toggled_on
