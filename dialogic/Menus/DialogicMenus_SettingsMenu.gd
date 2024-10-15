extends Control

onready var MenusContainer = get_parent().get_parent().get_parent()

################################################################################
##								PUBLIC
################################################################################

func open() -> void:
	show()
	$MainVolume.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	$MusicVolume.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	$SoundVolume.value = db2linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

################################################################################
##								PRIVATE
################################################################################

func _ready() -> void:
	hide()
	if OS.window_fullscreen == true:
		$Display_Fullscreen.disabled = true
	elif OS.window_fullscreen == false:
		$Display_Windows.disabled = true

func _on_Display_Fullscreen_pressed():
	OS.window_fullscreen = true
	$Display_Fullscreen.disabled = true
	$Display_Windows.disabled = false

func _on_Display_Windows_pressed():
	OS.window_fullscreen = false
	$Display_Windows.disabled = true
	$Display_Fullscreen.disabled = false

func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))

func _on_MainVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))

func _on_SoundVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))

func _on_Back_Button_pressed():
	if MenusContainer.is_game_playing() == true:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_navigation_menu()
		get_parent().get_parent().navigation_menu = true
		get_tree().set_input_as_handled()
	elif MenusContainer.get_node("MainMenu").settings_menu == 1:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_main_menu()
		get_tree().set_input_as_handled()
	else:
		get_parent().get_parent().hide_current()

