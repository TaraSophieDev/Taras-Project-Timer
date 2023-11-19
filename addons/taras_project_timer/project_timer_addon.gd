@tool
extends EditorPlugin

var project_timer
var time: String = "Project Timer"

func _enter_tree():
	project_timer = preload("res://addons/taras_project_timer/scenes/project_timer.tscn").instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, project_timer)

func _exit_tree():
	remove_control_from_docks(project_timer)
	project_timer.free()
