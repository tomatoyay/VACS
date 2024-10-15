extends Control

onready var animation = $ChurchDoor/ChurchDoorButton/ChurchDoorHover
onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")
onready var door_open = $ChurchDoor/Door_Open
onready var murder_anim = $MurderScene/Murder_Animation
onready var door_zoom = $ChurchDoor/ChurchDoorZoom

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(1.0), "timeout")
	door_zoom.play("Zoom In")
	yield(get_tree().create_timer(2.0), "timeout")

func _on_dialogic_signal(argument:String):
	if argument == "Credits":
		var scene = load("res://GodotCredits.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)


func _on_ChurchDoorButton_pressed():
	door_open.play()
	animation.play("ChurchDoor_Fade")
	yield(animation, "animation_finished")
	yield(get_tree().create_timer(1.0), "timeout")
	murder_anim.play("Murder Scene")
	yield(murder_anim, "animation_finished")
	yield(get_tree().create_timer(1.0), "timeout")
	var dialog = Dialogic.start("Church Crime Scene")
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
	get_parent().add_child(dialog)

func _on_ChurchDoorButton_mouse_entered():
	#animation.play("ChurchDoor")
	pass

func _on_ChurchDoorButton_mouse_exited():
	#animation.play("Church_Door_Back")
	pass
