extends TabContainer
@onready var labels = get_tree().get_nodes_in_group("TalentLabel")
var view_descr: bool = false

func _ready():
	for label in labels:
		label.visible = view_descr
		label.clear()  # Clear the existing text
		var lines = label.text.split("\n")
		for line in lines:
			add_colored_text(label, line)

func add_colored_text(labenode, line):
	var parts = line.split(" ")
	var check: int = 0
	for i in range(len(parts)):
		var color = Color("cccccc")
		if (i > 0 and i+1 < range(len(parts)).size() and (parts[i+1] == "Roll" or parts[i+1] == "Maneuver" or parts[i+1] == "Rolls" or parts[i+1] == "Roll." or parts[i+1] == "Rolls.")):
			color = Color("ff6900")
			check = i+1
		elif (i == check and parts[i] == "Maneuver" or parts[i] == "Roll" or parts[i] == "Rolls" or parts[i] == "Roll." or parts[i] == "Rolls."):
			color = Color("ff6900")
		elif parts[i].ends_with("T)") or parts[i].ends_with("T)."):
			color = Color("ff6900")
			
		elif parts[i].find("-") != -1 or parts[i].ends_with(":") or parts[i].begins_with("[") :
			color = Color("dfe288")
		labenode.push_color(color)
		labenode.add_text(parts[i] + " ")
		labenode.pop()
	labenode.add_text("\n")

