extends Area2D

@onready var portal_animations: AnimatedSprite2D = $Portal_animation

var entered: bool = false

func _ready() -> void:
	portal_animations.play("default")
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if entered:
		return
	
	if body.is_in_group("player"):
		print("Player enter portal")
		entered = true
		
		await get_tree().create_timer(0.5).timeout
		
		var current_scene := get_tree().current_scene.scene_file_path
		var next_scene := ""
		
		match current_scene:
			"res://Scenes/level_01.tscn":
				next_scene = "res://Scenes/level_02.tscn"
			"res://Scenes/level_02.tscn":
				next_scene = "res://Scenes/level_03.tscn"
			"res://Scenes/level_03.tscn":
				next_scene = "res://Scenes/level_04.tscn"
			"res://Scenes/level_04.tscn":
				next_scene = "res://Scenes/level_05.tscn"
			"res://Scenes/level_05.tscn":
				print("Last level! Game complete!")
				return
		
		if next_scene != "":
			_change_scene(next_scene)


func _change_scene(scene_path: String) -> void:
	# ResourceLoader корректно работает и в редакторе, и в экспортированной игре
	if not ResourceLoader.exists(scene_path):
		push_error("Portal: ресурс сцены не найден — %s" % scene_path)
		return
	
	# Безопасная отложенная смена сцены
	get_tree().call_deferred("change_scene_to_file", scene_path)
