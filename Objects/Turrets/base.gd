extends StaticBody2D

func _ready() -> void:
    get_parent().add_to_group("Object")
    get_parent().add_to_group("Entities")
    
    if not get_parent().main_menu_mode :
        $AudioStreamPlayer2D.play()
