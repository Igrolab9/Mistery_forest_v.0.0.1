extends CanvasLayer

@onready var _start_button: Button = $Start_game_button
@onready var _authors_button: Button = $Authors_scene_button

const LEVEL_01: String = "res://Scenes/level_01.tscn"
const AUTHOR_SCENE: String = "res://Scenes/authors_scene.tscn"

func _ready() -> void:
	_start_button.pressed.connect(_on_start_game_pressed)
	_authors_button.pressed.connect(_on_authors_button_pressed)


func _on_start_game_pressed() -> void:
	_change_scene(LEVEL_01)


func _on_authors_button_pressed() -> void:
	_change_scene(AUTHOR_SCENE)


func _change_scene(scene_path: String) -> void:
	# Проверяем сцену через ResourceLoader.
	# Это корректно работает и в редакторе, и в экспортированной игре.
	if not ResourceLoader.exists(scene_path):
		push_error("MainMenu: ресурс сцены не найден — %s" % scene_path)
		return
	
	# Безопасная отложенная смена сцены
	get_tree().call_deferred("change_scene_to_file", scene_path)
