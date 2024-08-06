extends Control
@onready var Upgrade = $BackgroundIMG/CloseAndSave
@onready var TalentLabel = $"BackgroundIMG/Talent Menu"
var view_descr: bool = false
@onready var labels = get_tree().get_nodes_in_group("TalentLabel")


func _on_close_and_save_pressed():
	hide()


func _on_show_descriptions_toggled(toggled_on):
	view_descr = toggled_on
	for label in labels:
		label.visible = view_descr
	
func _on_adept_warrior_toggled(_toggled_on):
	return


func _on_combat_expertise_toggled(_toggled_on):
	return

