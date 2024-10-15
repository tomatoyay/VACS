extends Node


# Declare member variables here. Examples:
var c_letter_finished = 0
onready var doc_anim = $Church_Letter_Animation
onready var canim = $Letter1_Button/Letter1_Animation
onready var canim2 = $Letter2_Button/Letter2_Animation
onready var canim3 = $Letter3_Button/Letter3_Animation
onready var canim4 = $Letter4_Button/Letter4_Animation
onready var canim5 = $Letter5_Button/Letter5_Animation
onready var canim6 = $Letter6_Button/Letter6_Animation
onready var canim7 = $Letter7_Button/Letter7_Animation
onready var canim8 = $Letter8_Button/Letter8_Animation
onready var canim9 = $Letter9_Button/Letter9_Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func c_letter_finish():
	if c_letter_finished == 9:
		doc_anim.play("RESET")
		yield(doc_anim,"animation_finished")
		yield(get_tree().create_timer(0.5), "timeout")
		var dialog = Dialogic.start("C_Letter_Outro")
		add_child(dialog)
		yield(dialog,'timeline_end')
		get_parent().get_parent().office_finish()
		get_parent().visible = false
		

#Letter1
func _on_Letter1_Button_mouse_entered():
	canim.play("Letter1_Animation")

func _on_Letter1_Button_mouse_exited():
	canim.play("RESET")

func _on_Letter1_Button_pressed():
	var dialog = Dialogic.start("CLetter_1")
	add_child(dialog)
	$Letter1_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()
	
	#Letter2
func _on_Letter2_Button_mouse_entered():
	canim2.play("Letter2_Show")

func _on_Letter2_Button_mouse_exited():
	canim2.play("RESET")

func _on_Letter2_Button_pressed():
	var dialog = Dialogic.start("CLetter_2")
	add_child(dialog)
	$Letter2_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()

#Letter3
func _on_Letter3_Button_mouse_entered():
	canim3.play("Letter3_Show")

func _on_Letter3_Button_mouse_exited():
	canim3.play("RESET")

func _on_Letter3_Button_pressed():
	var dialog = Dialogic.start("CLetter_3")
	add_child(dialog)
	$Letter3_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()

#Letter4
func _on_Letter4_Button_mouse_entered():
	canim4.play("Letter4_Show")

func _on_Letter4_Button_mouse_exited():
	canim4.play("RESET")

func _on_Letter4_Button_pressed():
	var dialog = Dialogic.start("CLetter_4")
	add_child(dialog)
	$Letter4_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()

#Letter5
func _on_Letter5_Button_mouse_entered():
	canim5.play("Letter5_Show")

func _on_Letter5_Button_mouse_exited():
	canim5.play("RESET")

func _on_Letter5_Button_pressed():
	var dialog = Dialogic.start("CLetter_5")
	add_child(dialog)
	$Letter5_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()

#Letter6
func _on_Letter6_Button_mouse_entered():
	canim6.play("Letter6_Show")

func _on_Letter6_Button_mouse_exited():
	canim6.play("RESET")

func _on_Letter6_Button_pressed():
	var dialog = Dialogic.start("CLetter_6")
	add_child(dialog)
	$Letter6_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()
	
	#Letter7
func _on_Letter7_Button_mouse_entered():
	canim7.play("Letter7_Show")

func _on_Letter7_Button_mouse_exited():
	canim7.play("RESET")

func _on_Letter7_Button_pressed():
	var dialog = Dialogic.start("CLetter_7")
	add_child(dialog)
	$Letter7_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()

#Letter8
func _on_Letter8_Button_mouse_entered():
	canim8.play("Letter8_Show")

func _on_Letter8_Button_mouse_exited():
	canim8.play("RESET")

func _on_Letter8_Button_pressed():
	var dialog = Dialogic.start("CLetter_8")
	add_child(dialog)
	$Letter8_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()
	
#Letter9
func _on_Letter9_Button_mouse_entered():
	canim9.play("Letter9_Show")

func _on_Letter9_Button_mouse_exited():
	canim9.play("RESET")

func _on_Letter9_Button_pressed():
	var dialog = Dialogic.start("CLetter_9")
	add_child(dialog)
	$Letter9_Button.visible = false
	yield(dialog,'timeline_end')
	c_letter_finished += 1
	c_letter_finish()
