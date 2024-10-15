extends Node

# Declare member variables here. Examples:
var t_letter_finished = 0
onready var throck_anim = $Throck_Letter_Animation
onready var tanim = $Letter1_Button/Letter1_Animation
onready var tanim2 = $Letter2_Button/Letter2_Animation
onready var tanim3 = $Letter3_Button/Letter3_Animation
onready var tanim4 = $Letter4_Button/Letter4_Animation
onready var tanim5 = $Letter5_Button/Letter5_Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_parent().get_node("Babinski_Letter/Babinski_Letter_Animation"))
	
func t_letter_finish():
	if t_letter_finished == 5:
		var dialog = Dialogic.start("T_Letter_Outro")
		throck_anim.play("RESET")
		yield(throck_anim,"animation_finished")
		yield(get_tree().create_timer(0.5), "timeout")
		add_child(dialog)
		yield(dialog,'timeline_end')
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().get_node("Babinski_Letter/Babinski_Letter_Animation").play("Babinski_Letter")
		

#Letter1
func _on_Letter1_Button_mouse_entered():
	tanim.play("Letter1_Animation")

func _on_Letter1_Button_mouse_exited():
	tanim.play("RESET")

func _on_Letter1_Button_pressed():
	var dialog = Dialogic.start("TLetter_1")
	add_child(dialog)
	$Letter1_Button.visible = false
	yield(dialog,'timeline_end')
	t_letter_finished += 1
	t_letter_finish()
	
	#Letter2
func _on_Letter2_Button_mouse_entered():
	tanim2.play("Letter2_Show")

func _on_Letter2_Button_mouse_exited():
	tanim2.play("RESET")

func _on_Letter2_Button_pressed():
	var dialog = Dialogic.start("TLetter_2")
	add_child(dialog)
	$Letter2_Button.visible = false
	yield(dialog,'timeline_end')
	t_letter_finished += 1
	t_letter_finish()

#Letter3
func _on_Letter3_Button_mouse_entered():
	tanim3.play("Letter3_Show")

func _on_Letter3_Button_mouse_exited():
	tanim3.play("RESET")

func _on_Letter3_Button_pressed():
	var dialog = Dialogic.start("TLetter_3")
	add_child(dialog)
	$Letter3_Button.visible = false
	yield(dialog,'timeline_end')
	t_letter_finished += 1
	t_letter_finish()

#Letter4
func _on_Letter4_Button_mouse_entered():
	tanim4.play("Letter4_Show")

func _on_Letter4_Button_mouse_exited():
	tanim4.play("RESET")

func _on_Letter4_Button_pressed():
	var dialog = Dialogic.start("TLetter_4")
	add_child(dialog)
	$Letter4_Button.visible = false
	yield(dialog,'timeline_end')
	t_letter_finished += 1
	t_letter_finish()

#Letter5
func _on_Letter5_Button_mouse_entered():
	tanim5.play("Letter5_Show")

func _on_Letter5_Button_mouse_exited():
	tanim5.play("RESET")

func _on_Letter5_Button_pressed():
	var dialog = Dialogic.start("TLetter_5")
	add_child(dialog)
	$Letter5_Button.visible = false
	yield(dialog,'timeline_end')
	t_letter_finished += 1
	t_letter_finish()

