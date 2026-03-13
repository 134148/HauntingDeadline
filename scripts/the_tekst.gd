extends Label

var index = 0

var dialogue_active = true

var dialogue = []

func _ready() -> void:
	if get_tree().current_scene.name == 'Robert_naar_comp':
		dialogue = [
			"Oh nee! Ik moet nog zoveel doen. Potverdriedubbeltjes. Helemaal vergeten dat ik informatica had! ",
			"Objective: ga naar de computer"
		]
	if get_tree().current_scene.name == 'robert_naar_koelkast':
		dialogue = [
			"Klaar! Gelukkig. Nu ben ik wel hongerig zeg *maag knort*. Laat ik maar naar de koelkast gaan voor wat eten!",
			"Objective: ga naar de koelkast"
		]
	if get_tree().current_scene.name == 'robert_terug':
		dialogue = [
			"mhm mhm mhm. Ik vind deze cookies beter dan die van een website! Wow. Zo tasty. ",
			"Oh nee, wie zou dat zijn?",
			"ROBERT! JIJ BENT NOG NIET KLAAR MET INFORMATICA.",
			"0_0",
			"Objective 4: REN. GA TERUG NAAR DE LAPTOP. "
		]
	if get_tree().current_scene.name == 'minigame1':
		dialogue = [
			"Oke, ik heb nog deze taken te doen...",
			"Objective: Haal 5 punten in het spel"
		]
	if dialogue.size() > 0:
		text = dialogue[index]
	print(get_tree().current_scene.name)
	print(dialogue)


	

func _input(event):
	if Input.is_action_just_pressed("space"):
		index += 1
		
		if index < dialogue.size():
			text = dialogue[index]

func _process(delta: float) -> void:
	if index > dialogue.size() - 1:
		%TextDisplay.hide()
		dialogue_active = false
