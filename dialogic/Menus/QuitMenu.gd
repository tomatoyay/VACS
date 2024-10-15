extends Control

onready var MenusContainer = get_parent().get_parent().get_parent()
################################################################################
##								PUBLIC
################################################################################

# will open this warning
func open() -> void:
	show()


################################################################################
##								PRIVATE
################################################################################

func _ready() -> void:
	pass
	
	
func _on_Yes_pressed():
	var save = GlobalVariables.save_data()
	GlobalVariables.save_game(save)
	get_tree().call("quit")


func _on_No_pressed():
	if MenusContainer.get_node("MainMenu").quit_menu == 1:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_main_menu()
	elif MenusContainer.is_game_playing() == true:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_navigation_menu()
		get_parent().get_parent().navigation_menu = true
	else:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_main_menu()
