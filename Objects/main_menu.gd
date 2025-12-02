extends Node2D



func _on_play_button_up() -> void:
    get_tree().change_scene_to_file("res://Objects/main.tscn")
    $BtnPress.play()

func _on_quit_button_up() -> void:
    get_tree().quit()
    $BtnPress.play()
