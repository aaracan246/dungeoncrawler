extends Node

var next_scene_path: String = ""
var loading_screen_scene: PackedScene = preload("res://scenes/loading_screen.tscn")
var loading_instance: Node = null

func load_scene_async(scene_path: String):
	next_scene_path = scene_path
	loading_instance = loading_screen_scene.instantiate()
	get_tree().root.add_child(loading_instance)
	call_deferred("_load_scene")

func _load_scene():
	await get_tree().create_timer(1).timeout
	await get_tree().create_timer(1).timeout
	var packed_scene = load(next_scene_path)
	get_tree().change_scene_to_packed(packed_scene)

	await get_tree().create_timer(0.1).timeout
	if loading_instance and loading_instance.is_inside_tree():
		loading_instance.queue_free()
		loading_instance = null

# SceneLoader.gd


#var loading_screen_scene: PackedScene = preload("res://scenes/loading_screen.tscn")
#var loading_instance: Node = null

func show_loading_screen(duration := 1.0) -> void:
	if loading_instance:
		return

	loading_instance = loading_screen_scene.instantiate()
	get_tree().root.add_child(loading_instance)
	await get_tree().create_timer(duration).timeout

func hide_loading_screen():
	if loading_instance and loading_instance.is_inside_tree():
		loading_instance.queue_free()
		loading_instance = null
