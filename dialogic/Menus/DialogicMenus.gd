extends Control

## references
onready var LooseWarning = $LooseProgressWarning
onready var LooseSaveWarning = $LooseSaveWarning
export (NodePath) var Game


# saved before pausing the game, used in case a save is created
var saved_image

var current_saved = false

################################################################################
##								PUBLIC
################################################################################

func add_game_node(node):
	stop_previous_game()
	$InGameMenu.hide()
	$MenuAnimations.play("Fade In")
	get_node(Game).add_child(node)
	yield($MenuAnimations, "animation_finished")
	$InGameMenu.show()
	$InGameMenu/Auto_Button.disabled = false
	$InGameMenu/Skip_Button.disabled = false
	$MainMenu.hide()
	$SubMenus.hide()
	$MenuAnimations.play_backwards("Fade In")
	$MenuMusic.playing = false
	resume_game()


func add_scene_node(node):
	stop_previous_game()
	$InGameMenu.hide()
	$InGameMenu/Auto_Button.disabled = false
	$InGameMenu/Skip_Button.disabled = false
	$MenuAnimations.play("Fade In")
	get_node(Game).add_child(node)
	yield($MenuAnimations, "animation_finished")
	$MainMenu.hide()
	$SubMenus.hide()
	$MenuAnimations.play_backwards("Fade In")
	$MenuMusic.playing = false
	resume_game()


func add_main_game_node(node):
	stop_previous_game()
	yield(get_tree(), "idle_frame")
	$InGameMenu.hide()
	$MenuAnimations.play("Fade In")
	get_node(Game).add_child(node)
	node.connect("timeline_end", self, "_on_game_ended")
	yield($MenuAnimations, "animation_finished")
	$InGameMenu.show()
	$InGameMenu/Auto_Button.disabled = false
	$InGameMenu/Skip_Button.disabled = false
	$MainMenu.hide()
	$SubMenus.hide()
	$MenuAnimations.play_backwards("Fade In")
	$MenuMusic.playing = false
	resume_game()


func stop_previous_game() -> void:
	for child in get_node(Game).get_children():
		child.queue_free()

func is_game_playing() -> bool:
	return bool(get_node(Game).get_child_count())

func pause_game():
	current_saved = false
	get_node(Game).hide()
	$MenuMusic.playing = true
	get_tree().paused = true

func resume_game():
	$SubMenus.current_menu = null
	get_node(Game).show()
	$MenuMusic.playing = false
	get_tree().paused = false

################################################################################
##								PRIVATE
################################################################################

func _ready():
	show()


################################################################################
##							IN-GAME BUTTONS
################################################################################

func _on_game_ended(_something):
	var ends = _endings()
	print(ends)
	stop_previous_game()
	yield(get_tree(), "idle_frame")
	if true_ending() == 1:
		$SubMenus/MenuContent/CharacterMenu/OrvenZanry_Control.visible = false
		$SubMenus/MenuContent/CharacterMenu/OrvenTrue_Control.visible = true
		$SubMenus/MenuContent/CharacterMenu/OrvenName.visible = false
		$SubMenus/MenuContent/CharacterMenu/PC_Background.visible = false
		$SubMenus/MenuContent/CharacterMenu/Etisia.visible = true
		$SubMenus/MenuContent/CharacterMenu/Minerva.visible = true
		$SubMenus/MenuContent/CharacterMenu/Ives.visible = true
		$SubMenus/MenuContent/CharacterMenu/Meldan.visible = true
		$SubMenus/MenuContent/CharacterMenu/Gou.visible = true
		$SubMenus/MenuContent/CharacterMenu/Orven_Endings.visible = true
		$SubMenus/MenuContent/CharacterMenu/OrvenName.visible = false
		$SubMenus/MenuContent/CharacterMenu/OrvenNameGold.visible = false
		$SubMenus/MenuContent/CharacterMenu/ChapterSelection.visible = true
		GlobalVariables.true_ending = 1
		GlobalVariables.endings = _endings()
	elif ends == 0:
		GlobalVariables.endings = _endings()
	else:
		$SubMenus/MenuContent/CharacterMenu/OrvenZanry_Control.visible = false
		$SubMenus/MenuContent/CharacterMenu/OrvenEnd_Control.visible = true
		$SubMenus/MenuContent/CharacterMenu/PC_Background.visible = false
		$SubMenus/MenuContent/CharacterMenu/Etisia.visible = true
		$SubMenus/MenuContent/CharacterMenu/Minerva.visible = true
		$SubMenus/MenuContent/CharacterMenu/Ives.visible = true
		$SubMenus/MenuContent/CharacterMenu/Meldan.visible = true
		$SubMenus/MenuContent/CharacterMenu/Gou.visible = true
		$SubMenus/MenuContent/CharacterMenu/Orven_Endings.visible = true
		$SubMenus/MenuContent/CharacterMenu/OrvenName.visible = false
		$SubMenus/MenuContent/CharacterMenu/OrvenNameGold.visible = false
		$SubMenus/MenuContent/CharacterMenu/ChapterSelection.visible = true
		if Dialogic.get_variable('neutral_ending1') == '1':
			GlobalVariables.orven_ending2 = 1
		elif Dialogic.get_variable('neutral_ending2') == '1':
			GlobalVariables.orven_ending3 = 1
		elif Dialogic.get_variable('neutral_ending3') == '1':
			GlobalVariables.orven_ending4 = 1
		elif Dialogic.get_variable('bad_ending1') == '1':
			GlobalVariables.orven_ending5 = 1
		elif Dialogic.get_variable('bad_ending2') == '1':
			GlobalVariables.orven_ending6 = 1
		GlobalVariables.endings = _endings()
	
	get_node("SubMenus/MenuContent/NavigationMenu").hide()
	get_node("SubMenus").open_character_menu()
	$MenuMusic.play()
	$SubMenus/SubMenuAnimation.play_backwards("Fade In")
	yield(get_tree().create_timer(0.5), "timeout")
	var save = GlobalVariables.save_data()
	GlobalVariables.save_game(save)
	show()

func _on_Auto_Button_toggled(button_pressed: bool):
	var button = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer/InGameMenu/Auto_Button")
	get_tree().set_input_as_handled()
	if button_pressed == true:
		Dialogic.auto_advance_on(true, 1)
	else:
		Dialogic.auto_advance_on(false)
		button.set_pressed_no_signal(false)
		
func _on_Skip_Button_toggled(button_pressed: bool):
	var button = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer/InGameMenu/Skip_Button")
	get_tree().set_input_as_handled()
	if button_pressed == true:
		Dialogic.auto_skip_on(true)
	else:
		Dialogic.auto_skip_on(false)
		button.set_pressed_no_signal(false)

func _on_History_Button_toggled(_button_pressed: bool):
	get_tree().set_input_as_handled()
	Dialogic.toggle_history()

func _on_History_Button_mouse_entered():
	Dialogic._set_InGameMenu_Button(true)

func _on_History_Button_mouse_exited():
	Dialogic._set_InGameMenu_Button(false)

func _on_Skip_Button_mouse_entered():
	Dialogic._set_InGameMenu_Button(true)

func _on_Skip_Button_mouse_exited():
	Dialogic._set_InGameMenu_Button(false)

func _on_Auto_Button_mouse_entered():
	Dialogic._set_InGameMenu_Button(true)

func _on_Auto_Button_mouse_exited():
	Dialogic._set_InGameMenu_Button(false)

func _endings() -> float:
	var sum = 0.0
	
	if Dialogic.get_variable('true_ending') == '1':
		GlobalVariables.true_ending = 1
		sum += 1
	if Dialogic.get_variable('neutral_ending1') == '1':
		GlobalVariables.orven_ending2 = 1
		sum += 1
	if Dialogic.get_variable('neutral_ending2') == '1':
		GlobalVariables.orven_ending3 = 1
		sum += 1
	if Dialogic.get_variable('neutral_ending3') == '1':
		GlobalVariables.orven_ending4 = 1
		sum += 1
	if Dialogic.get_variable('bad_ending1') == '1':
		GlobalVariables.orven_ending5 = 1
		sum += 1
	if Dialogic.get_variable('bad_ending2') == '1':
		GlobalVariables.orven_ending6 = 1
		sum += 1
		
	return sum

func true_ending():
	var true_end = int(Dialogic.get_variable('true_ending'))
	return true_end
