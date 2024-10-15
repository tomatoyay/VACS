extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var mainGameScene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog = Dialogic.start("Introduction")
	add_child(dialog)

	#get_tree().change_scene(mainGameScene.resource_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
