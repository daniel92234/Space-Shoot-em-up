class_name ScreenVisibleComponent extends VisibleOnScreenNotifier2D

var entered_screen := false
var on_screen := false

func _ready() -> void:
	screen_entered.connect(_on_screen_entered)
	screen_exited.connect(_on_screen_exited)
	
func _on_screen_entered() -> void:
	entered_screen = true
	on_screen = true

func _on_screen_exited() -> void:
	on_screen = false
