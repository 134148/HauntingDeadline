extends Label

var dialogue = [
	"Oh nee! Ik moet nog zoveel doen. Potverdriedubbeltjes. Helemaal vergeten dat ik informatica had! ",
	"Objective: ga naar de computer"
]

var index = 0

func _ready():
	text = dialogue[index]

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		index += 1
		
		if index < dialogue.size():
			text = dialogue[index]
