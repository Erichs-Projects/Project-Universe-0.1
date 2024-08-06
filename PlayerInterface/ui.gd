extends CanvasLayer
signal movement_on
signal show_attack_range(inputbool)
signal character_sheet
signal boosted_speed(check)

@onready var charactersheetbutton = $Control/MenuBar/MainUI/GridContainer/Character
@onready var InstantManueverM = $Control/MenuBar/InstantSubUI
@onready var AttackManueverM = $Control/MenuBar/AttackSubUI

func _on_movement_pressed():
	
	movement_on.emit()

func _on_ui_button_pressed():
	hide()


func _on_instant_toggled(toggled_on):
	if toggled_on:
		InstantManueverM.show()
		
	else:
		InstantManueverM.hide()
	

func _on_standard_toggled(toggled_on):
	if toggled_on:
		AttackManueverM.show()
		
	else:
		AttackManueverM.hide()


func _on_scale_up_pressed():
	scale += Vector2(0.02, 0.02)


func _on_scale_down_pressed():
	scale -= Vector2(0.02, 0.02)


func _on_attack_toggled(toggled_on):
	show_attack_range.emit(toggled_on)


func _on_menu_button_pressed():
	get_tree().change_scene_to_file('res://scenes/menu.tscn')


func _on_character_toggled(toggled_on):
	character_sheet.emit(toggled_on)


func _on_check_button_toggled(toggled_on):
	boosted_speed.emit(toggled_on)
	
