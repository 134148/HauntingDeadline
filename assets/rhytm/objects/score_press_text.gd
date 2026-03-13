extends Control


#perfect ff7df3

#great ee9f97

#good 4ad2a2

#ok 42c5ff

#miss b7b6b2

func SetTextInfo(text: String):
	$ScoreLevelText.clear()
	$ScoreLevelText.append_text("[center]" + text + "[/center]")

	match text:
		"PERFECT!":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("ffd700"))
		"GREAT!":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("00ff00"))
		"GOOD!":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("4ad2a2"))
		"OK!":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("42c5ff"))
		"MISS!":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("b76bb2"))
			
			
			
			
