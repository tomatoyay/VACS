extends Control

onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")
onready var tween_out = get_node("Tween")
export var transition_duration = 4.00
export var transition_type = 1 # TRANS_SINE

func fade_out(stream_player):
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped

func _on_TweenOut_tween_completed(object, _key):
	# stop the music -- otherwise it continues to run at silent volume
	object.stop()
# Called when the node enters the scene tree for the first time.

func _ready():
	$MapMusic.playing = true
	$Map_Animation.play("Map Open")
	yield(get_tree().create_timer(1.0), "timeout")
	var dialog = Dialogic.start("Map 1")
	add_child(dialog)
	yield(dialog,'timeline_end')

func _on_dialogic_signal(argument:String):
	MenusContainer._on_Auto_Button_toggled(false)
	MenusContainer._on_Skip_Button_toggled(false)
	if argument == "Map0":
		var scene = load("res://Map/Map.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Tootroot0":
		var scene = load("res://Tootroot/Tootroot0.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "rejection_letter":
		var scene = load("res://Rejection_Letter/Rejection_Letter.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Map1":
		var scene = load("res://Map/Map1.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == 'Sion_Hallway_Odiche':
		var scene = load("res://Hallway/Hallway_Miss_Odiche.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == 'Sion_Hallway_Herb':
		var scene = load("res://Hallway/Hallway_Herb.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Sion_Office":
		var scene = load("res://Gungand_Office/Gungand_Office.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Church_Door":
		var scene = load("res://Church_door.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Credits":
		var scene = load("res://GodotCredits.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false

func _on_ABP_pressed():
	$Map/ABP.disabled = true
	$Map/Orven_Home.disabled = true
	var dialog = Dialogic.start("ABP Intro")
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
	MenusContainer.get_node('InGameMenu').show()
	yield(get_tree().create_timer(1.0), "timeout")
	fade_out($MapMusic)
	get_parent().add_child(dialog)


func _on_Orven_Home_pressed():
	$Map/ABP.disabled = true
	$Map/Orven_Home.disabled = true
	var dialog = Dialogic.start("Home 1 Intro")
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
	MenusContainer.get_node('InGameMenu').show()
	yield(get_tree().create_timer(1.0), "timeout")
	get_parent().add_child(dialog)
	fade_out($MapMusic)

func _on_ABP_mouse_entered():
	$Map/ABP/ABP_Animation.play("ABP Hover")

func _on_ABP_mouse_exited():
	$Map/ABP/ABP_Animation.play("RESET")

func _on_Orven_Home_mouse_entered():
	$Map/Orven_Home/Orven_Home_Anim.play("Orven Home Hover")

func _on_Orven_Home_mouse_exited():
	$Map/Orven_Home/Orven_Home_Anim.play("RESET")


func _on_Avidine_Factory_mouse_entered():
	$Map/Avidine_Factory/Factory_Label.visible = true

func _on_Avidine_Factory_mouse_exited():
	$Map/Avidine_Factory/Factory_Label.visible = false

func _on_Shop_mouse_entered():
	$Map/Shop/Shop_Label.visible = true

func _on_Shop_mouse_exited():
	$Map/Shop/Shop_Label.visible = false

func _on_Police_Station_mouse_entered():
	$Map/Police_Station/Police_Label.visible = true

func _on_Police_Station_mouse_exited():
	$Map/Police_Station/Police_Label.visible = false

func _on_Mortuary_mouse_entered():
	$Map/Mortuary/Mortuary_Label.visible = true

func _on_Mortuary_mouse_exited():
	$Map/Mortuary/Mortuary_Label.visible = false

func _on_Liz_mouse_entered():
	$Map/Liz/Liz_Label.visible = true

func _on_Liz_mouse_exited():
	$Map/Liz/Liz_Label.visible = false

func _on_Orphanage_mouse_entered():
	$Map/Orphanage/Orphanage_Label.visible = true

func _on_Orphanage_mouse_exited():
	$Map/Orphanage/Orphanage_Label.visible = false

func _on_Church_mouse_entered():
	$Map/Church/Church_Label.visible = true

func _on_Church_mouse_exited():
	$Map/Church/Church_Label.visible = false

func _on_Hospital_mouse_entered():
	$Map/Hospital/Hospital_Label.visible = true

func _on_Hospital_mouse_exited():
	$Map/Hospital/Hospital_Label.visible = false

func _on_Avidine_Manor_mouse_entered():
	$Map/Avidine_Manor/Manor_Label.visible = true

func _on_Avidine_Manor_mouse_exited():
	$Map/Avidine_Manor/Manor_Label.visible = false

func _on_Jones_Apotheca_mouse_entered():
	$Map/Jones_Apotheca/Apotheca_Label.visible = true

func _on_Jones_Apotheca_mouse_exited():
	$Map/Jones_Apotheca/Apotheca_Label.visible = false

func _on_Construction_Site_mouse_entered():
	$Map/Construction_Site/Construction_Label.visible = true

func _on_Construction_Site_mouse_exited():
	$Map/Construction_Site/Construction_Label.visible = false

func _on_School_Southside_mouse_entered():
	$Map/School_Southside/School_South_Label.visible = true

func _on_School_Southside_mouse_exited():
	$Map/School_Southside/School_South_Label.visible = false

func _on_School_Northside_mouse_entered():
	$Map/School_Northside/School_North_Label.visible = true

func _on_School_Northside_mouse_exited():
	$Map/School_Northside/School_North_Label.visible = false

func _on_Zirgfir_Manor_mouse_entered():
	$Map/Zirgfir_Manor/Zirgfir_Label.visible = true

func _on_Zirgfir_Manor_mouse_exited():
	$Map/Zirgfir_Manor/Zirgfir_Label.visible = false

func _on_Bank_mouse_entered():
	$Map/Bank/Bank_Label.visible = true

func _on_Bank_mouse_exited():
	$Map/Bank/Bank_Label.visible = false

func _on_Police_Station2_mouse_entered():
	$Map/Police_Station2/Police2_Label.visible = true

func _on_Police_Station2_mouse_exited():
	$Map/Police_Station2/Police2_Label.visible = false

func _on_Municipal_Buildlings_mouse_entered():
	$Map/Municipal_Buildlings/Municipal_Label.visible = true

func _on_Municipal_Buildlings_mouse_exited():
	$Map/Municipal_Buildlings/Municipal_Label.visible = false

func _on_Shop2_mouse_entered():
	$Map/Shop2/Shop2_Label.visible = true

func _on_Shop2_mouse_exited():
	$Map/Shop2/Shop2_Label.visible = false

func _on_ABP2_mouse_entered():
	$Map/ABP2/ABP2_Label.visible = true

func _on_ABP2_mouse_exited():
	$Map/ABP2/ABP2_Label.visible = false

func _on_ABP3_mouse_entered():
	$Map/ABP3/ABP3_Label.visible = true

func _on_ABP3_mouse_exited():
	$Map/ABP3/ABP3_Label.visible = false

func _on_Valentine_Apartments_mouse_entered():
	$Map/Valentine_Apartments/Val_Apt_Label.visible = true

func _on_Valentine_Apartments_mouse_exited():
	$Map/Valentine_Apartments/Val_Apt_Label.visible = false

func _on_Valentine_Mill_mouse_entered():
	$Map/Valentine_Mill/Val_Mill_Label.visible = true

func _on_Valentine_Mill_mouse_exited():
	$Map/Valentine_Mill/Val_Mill_Label.visible = false

func _on_ABP4_mouse_entered():
	$Map/ABP4/ABP4_Label.visible = true

func _on_ABP4_mouse_exited():
	$Map/ABP4/ABP4_Label.visible = false

func _on_Dr_Ki_Clinic_mouse_entered():
	$Map/Dr_Ki_Clinic/Ki_Clinic_Label.visible = true

func _on_Dr_Ki_Clinic_mouse_exited():
	$Map/Dr_Ki_Clinic/Ki_Clinic_Label.visible = false

func _on_Apartments2_mouse_entered():
	$Map/Apartments2/Apartments_Label.visible = true

func _on_Apartments2_mouse_exited():
	$Map/Apartments2/Apartments_Label.visible = false

func _on_Shop3_mouse_entered():
	$Map/Shop3/Shop3_Label.visible = true

func _on_Shop3_mouse_exited():
	$Map/Shop3/Shop3_Label.visible = false

func _on_Tavern_mouse_entered():
	$Map/Tavern/Tavern_Label.visible = true

func _on_Tavern_mouse_exited():
	$Map/Tavern/Tavern_Label.visible = false
