extends CanvasLayer

@onready var _back_button: Button = $Back_button

const MAIN_MENU: String = "res://Scenes/main_menu.tscn"

func _ready() -> void:
	_back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	_change_scene(MAIN_MENU)

func _change_scene(scene_path: String) -> void:
	# Проверяем сцену через ResourceLoader.
	# Это корректно работает и в редакторе, и в экспортированной игре.
	if not ResourceLoader.exists(scene_path):
		push_error("MainMenu: ресурс сцены не найден — %s" % scene_path)
		return
	
	# Безопасная отложенная смена сцены
	get_tree().call_deferred("change_scene_to_file", scene_path)
