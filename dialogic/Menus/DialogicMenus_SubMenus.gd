extends Control

# what menu is currently shown
var current_menu = null
onready var MenusContainer = get_parent()

################################################################################
##								PUBLIC
################################################################################

func open_main_menu():
	hide_current()
	current_menu = null
	hide()
	get_parent().get_node("MainMenu").open()

	
func open_character_menu():
	get_parent().get_node("InGameMenu").visible = false
	if current_menu == $MenuContent/CharacterMenu: return
	#check_resume()
	show()
	hide_current()
	current_menu = $MenuContent/CharacterMenu
	current_menu.open()


func open_save_menu():
	if current_menu == $MenuContent/SaveMenu: return
	#check_resume()
	show()
	hide_current()
	current_menu = $MenuContent/SaveMenu
	current_menu.open()

func open_load_menu():
	if current_menu == $MenuContent/LoadMenu: return
	#check_resume()
	show()
	hide_current()
	current_menu = $MenuContent/LoadMenu
	current_menu.open()

func open_settings_menu():
	if current_menu == $MenuContent/SettingsMenu: return
	#check_resume()
	show()
	hide_current()
	current_menu = $MenuContent/SettingsMenu
	current_menu.open()

func open_quit_menu():
	if current_menu == $MenuContent/QuitMenu: return
	#check_resume()
	show()
	hide_current()
	current_menu = $MenuContent/QuitMenu
	current_menu.open()

func open_navigation_menu():
	hide_current()
	if current_menu == $MenuContent/NavigationMenu: return
	#check_resume()
	show()
	hide_current()
	current_menu = $MenuContent/NavigationMenu
	current_menu.open()

func hide_current():
	if current_menu: current_menu.hide()
	get_parent().get_node("MenuAnimations").play("RESET")

# will show or hide the Resume_Button based on whether a game is currently playing
#func check_resume():
#	$MenuContent/NavigationMenu/Buttons/ResumeGame_Button.visible = get_parent().is_game_playing()

################################################################################
##								PRIVATE
################################################################################

func _ready():
	hide()

## SIGNALS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#func _on_MainMenu_Button_pressed():
#	if get_parent().is_game_playing() and not get_parent().current_saved:
#		get_parent().LooseWarning.open(self, "open_main_menu")
#	else:
#		open_main_menu()

func _on_SaveMenu_Button_pressed():
	open_save_menu()
	navigation_menu = null

func _on_LoadMenu_Button_pressed():
	open_load_menu()
	navigation_menu = null

func _on_Settings_Button_pressed():
	open_settings_menu()
	navigation_menu = null

func _on_Quit_Button_pressed():
	open_quit_menu()
	navigation_menu = null
	
func _on_CharacterMenu_pressed():
	if MenusContainer.is_game_playing() == true:
			MenusContainer.LooseWarning.open(self, "open_character_menu")
	else:
		hide_current()
		hide()
		open_character_menu()

var navigation_menu = false

func _input(_event):
	if MenusContainer.get_node("InGameMenu").visible == true:
		if MenusContainer.is_game_playing() == true and Input.is_action_just_pressed("ui_escape") and navigation_menu == false:
			get_tree().set_input_as_handled()  # Prevent the event from propagating further if needed
			# Retrieve the save screenshot
			get_parent().saved_image = get_tree().get_root().get_texture().get_data()
			get_parent().saved_image.flip_y()
			get_parent().pause_game()
			open_navigation_menu()
			navigation_menu = true
		elif $MenuContent/NavigationMenu.visible == true and Input.is_action_just_pressed("ui_escape") and navigation_menu == true:
			hide_current()
			current_menu = null
			hide()
			get_parent().resume_game()
			get_tree().set_input_as_handled()
			navigation_menu = false
		elif MenusContainer.is_game_playing() == true and Input.is_action_just_pressed("ui_escape") and navigation_menu == null:
			get_tree().set_input_as_handled()  # Prevent the event from propagating further if needed
			# Retrieve the save screenshot
			get_parent().saved_image = get_tree().get_root().get_texture().get_data()
			get_parent().saved_image.flip_y()
			get_parent().pause_game()
			open_navigation_menu()
			navigation_menu = true
		else:
			pass
