extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

onready var end_anim = $Thank_You/End_Screen_Anim

var credits = [
	[
		"CREDITS"
	],
	[
		"A game by Spicy Bread Productions, LLC",
	],[
		"Story",
		"Renee Huang"
	],[
		"Programming",
		"Vivian Zhang",
	],[
		"Art",
		"Elizabeth Hwang, character artist",
		"",
		"Stephanie Gamarra, background artist",
	],[
		"Music",
		"Vivian Zhang",
	],[
		"Sound Effects",
		"Internet",
	],[
		"Business",
		"Erica Yee",
	],[
		"Testers",
		"Ben Fickes",
				"",
		"Erica Yee",
				"",
		"Emma Barry",
				"",
		"Alex Zhang",
				"",
		"Daniel Hui",
				"",
		"Vincent Brown",
		#"Name 3"
	],[
		"Tools used",
		"Developed with Godot Engine",
				"",
		"https://godotengine.org/license",
		"",
		"Dialogic",
		"",
		"https://github.com/dialogic-godot/dialogic",
	],[
		"Special Thanks",
		"Gloria and Clark Huang",
				"",
		"Alex Zhang",
	]
]

func _ready():
	$Label.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	$Label.visible = false

func _process(delta):
	yield(get_tree().create_timer(3.0), "timeout")
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		$CreditsContainer.hide()
		yield(get_tree().create_timer(1.0), "timeout")
		end_anim.play("Fade In")
		$Thank_You.show()
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Continue_pressed():
	get_parent().get_parent().get_node('Menus/MenuContainer')._on_game_ended(finished)
	$CreditsMusic.playing = false

func add_line():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://fonts/WILLOW__.TTF")
	dynamic_font.size = 40
	dynamic_font.outline_color = title_color
	dynamic_font.use_filter = true
	
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_font_override("font", dynamic_font)
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false


func _on_Steam_pressed():
	OS.shell_open("https://store.steampowered.com/app/2992580/Ventreville_A_Cure_for_Sorrow/")

func _on_Tiktok_pressed():
	OS.shell_open("https://www.tiktok.com/@_spicy_bread")

func _on_Instagram_pressed():
	OS.shell_open("https://www.instagram.com/spicybreadproductions/")

func _on_Youtube_pressed():
	OS.shell_open("https://www.youtube.com/@SpicyBreadProductions")

func _on_Threads_pressed():
	OS.shell_open("https://www.threads.net/@spicybreadproductions")

func _on_X_pressed():
	OS.shell_open("https://x.com/spicybreadprods")

func _on_Tumblr_pressed():
	OS.shell_open("https://www.tumblr.com/spicybreadproductions")

func _on_Kickstarter_pressed():
	OS.shell_open("https://www.kickstarter.com/profile/spicybreadprods/")

