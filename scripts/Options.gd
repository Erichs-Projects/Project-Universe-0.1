extends Control
@onready var texture1 = $TextureRect
@onready var texture2 = $TextureRect2
@onready var texture3 = $TextureRect3
@onready var wallpaperOptions: Array = [texture1, texture2, texture3]

func _ready():
	texture1.visible = false
	texture1.visible = false	
	texture1.visible = false
	var current_wallpaper: TextureRect = wallpaperOptions.pick_random()
	current_wallpaper.visible = true
	

func _on_back_pressed():
	get_tree().change_scene_to_file('res://scenes/menu.tscn')
	
