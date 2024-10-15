extends Control

var settings_menu
var quit_menu
var new_game
onready var parent = get_parent()
onready var disclaim_anim = parent.get_node('Disclaimer/Disclaimer_Anim')
onready var fade_anim = parent.get_node('MenuAnimations')

################################################################################
##								PUBLIC
################################################################################

func open():
	GlobalVariables.save = get_parent().get_parent().get_parent().file_exists("user://Save 0/thumbnail.png")
	if GlobalVariables.save == true:
		$NewGame_Button.visible = false
		$CharacterMenu_Button.visible = true
		$NewGame_Button_Load.visible = true
	else:
		$NewGame_Button.visible = true
	yield(get_tree().create_timer(0.2), "timeout")
	fade_anim.play("Fade In")
	show()
	parent.get_node("MenuMusic").playing = true
	yield(get_tree().create_timer(0.2), "timeout")
	$NewGame_Button.grab_focus()


################################################################################
##								PRIVATE
################################################################################

func _ready():
	GlobalVariables.save = get_parent().get_parent().get_parent().file_exists("user://Save 0/thumbnail.png")
	
	parent.get_node("MenuMusic").playing = false
	parent.get_node('Splash').visible = true
	yield(get_tree().create_timer(4), "timeout")
	parent.get_node('Splash').visible = false
	yield(get_tree().create_timer(1), "timeout")
	
	if GlobalVariables.save == false:
		parent.get_node('Disclaimer').visible = true
		disclaim_anim.play("Disclaimer On")
		yield(disclaim_anim, "animation_finished")
		yield(get_tree().create_timer(4), "timeout")
		disclaim_anim.play("Disclaimer Off")
		yield(disclaim_anim, "animation_finished")
	else:
		parent.get_node('Disclaimer').visible = false
	
	open()
	yield(get_tree().create_timer(0.2), "timeout")


func _on_NewGame_Button_pressed():
	new_game = 1
	hide()
	get_parent().get_node("SubMenus").open_character_menu()
	$NewGame_Button.release_focus()
	
func _on_CharacterMenu_Button_pressed():
	hide()
	get_parent().get_node("SubMenus").open_character_menu()

func _on_Settings_Button_pressed():
	hide()
	get_parent().get_node("SubMenus").open_settings_menu()
	settings_menu = 1

func _on_Quit_Button_pressed():
	hide()
	get_parent().get_node("SubMenus").open_quit_menu()
	quit_menu = 1


