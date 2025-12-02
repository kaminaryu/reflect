extends Control

var c:int = 0 
var total = 0

func _process(delta: float) -> void:
    $HpBar.texture.current_frame = GlobalStats.player_health
    $ExpBar.texture.current_frame = GlobalStats.sonar_energy
    
    if GlobalStats.player_health < 1 :
        $GameOver.visible = true
    else :
        $GameOver.visible = false
        
        
    # disable if broke
    if GlobalStats.player_money < 5 :
        $WeaponBar/VBoxContainer/Crystal.disabled = true
        $WeaponBar/VBoxContainer/Crystal.modulate = Color(0.67, 0.67, 0.67)
    else :
        $WeaponBar/VBoxContainer/Crystal.disabled = false
        $WeaponBar/VBoxContainer/Crystal.modulate = Color(1, 1, 1)
        
    if GlobalStats.player_money < 7 :
        $WeaponBar/VBoxContainer/Twin.disabled = true
        $WeaponBar/VBoxContainer/Twin.modulate = Color(0.67, 0.67, 0.67)
    else :
        $WeaponBar/VBoxContainer/Twin.disabled = false
        $WeaponBar/VBoxContainer/Twin.modulate = Color(1, 1, 1)
        
    if GlobalStats.player_money < 12 :
        $WeaponBar/VBoxContainer/Arch.disabled = true
        $WeaponBar/VBoxContainer/Arch.modulate = Color(0.67, 0.67, 0.67)
    else :
        $WeaponBar/VBoxContainer/Arch.disabled = false
        $WeaponBar/VBoxContainer/Arch.modulate = Color(1, 1, 1)


var tween:Tween
var tween2:Tween

@onready var pos:Vector2 = $GameOver/Retry.position
@onready var pos2:Vector2 = $GameOver/Menu.position


func _on_retry_mouse_entered() -> void :
    if tween: tween.kill()
    tween = get_tree().create_tween().set_parallel(1)
    tween.tween_property($GameOver/Retry, "scale", Vector2(1.1, 1.1), 0.08)
    tween.tween_property($GameOver/Retry, "position", pos + Vector2(-25, -6), 0.08)
    tween.tween_property($GameOver/Retry, "modulate", Color(1.2, 1.2, 1.2), 0.08)

func _on_retry_mouse_exited() -> void :
    if tween: tween.kill()
    tween = get_tree().create_tween().set_parallel()
    tween.tween_property($GameOver/Retry, "scale", Vector2(1, 1), 0.08)
    tween.tween_property($GameOver/Retry, "position", pos, 0.08)
    tween.tween_property($GameOver/Retry, "modulate", Color(1, 1, 1), 0.08)

func _on_retry_button_up() -> void:
    Brain.reset_game()
    get_tree().reload_current_scene()
    $BtnPress.play()
    pass # Replace with function body.


# im lazy ok
func _on_menu_mouse_entered() -> void:
    if tween2: tween2.kill()
    tween2 = get_tree().create_tween().set_parallel()
    tween2.tween_property($GameOver/Menu, "scale", Vector2(1.1, 1.1), 0.08)
    tween2.tween_property($GameOver/Menu, "position", pos2 + Vector2(-25, -6), 0.08)
    tween2.tween_property($GameOver/Menu, "modulate", Color(1.2, 1.2, 1.2), 0.08)


func _on_menu_mouse_exited() -> void:
    if tween2: tween2.kill()
    tween2 = get_tree().create_tween().set_parallel()
    tween2.tween_property($GameOver/Menu, "scale", Vector2(1, 1), 0.08)
    tween2.tween_property($GameOver/Menu, "position", pos2, 0.08)
    tween2.tween_property($GameOver/Menu, "modulate", Color(1, 1, 1), 0.08)


func _on_menu_button_up() -> void:
    get_tree().change_scene_to_file("res://Objects/main_menu.tscn")
    $BtnPress.play()


func _on_crystal_button_up() -> void:
    TurretBuilder.buy_turret(0)
    $BtnPress.play()


func _on_twin_button_up() -> void:
    TurretBuilder.buy_turret(1)
    $BtnPress.play()


func _on_arch_button_up() -> void:
    TurretBuilder.buy_turret(2)
    $BtnPress.play()


func _on_crystal_mouse_entered() -> void:
    $WeaponBar/VBoxContainer/Crystal/Price.visible = true


func _on_crystal_mouse_exited() -> void:
    $WeaponBar/VBoxContainer/Crystal/Price.visible = false


func _on_twin_mouse_entered() -> void:
    $WeaponBar/VBoxContainer/Twin/Price.visible = true


func _on_twin_mouse_exited() -> void:
    $WeaponBar/VBoxContainer/Twin/Price.visible = false


func _on_arch_mouse_entered() -> void:
    $WeaponBar/VBoxContainer/Arch/Price.visible = true


func _on_arch_mouse_exited() -> void:
    $WeaponBar/VBoxContainer/Arch/Price.visible = false


func _on_resume_button_up() -> void:
    pass # Replace with function body.


func _on_resume_mouse_entered() -> void:
    pass # Replace with function body.


func _on_resume_mouse_exited() -> void:
    pass # Replace with function body.




func _on_button_button_up() -> void:
    Brain.game_running = true
    $PauseMenu.visible = false
    $BtnPress.play()


var tween3;
@onready var pos3 = $PauseMenu/Button.position

func _on_button_mouse_entered() -> void:
    if tween3: tween3.kill()
    tween3 = get_tree().create_tween().set_parallel()
    tween3.tween_property($PauseMenu/Button, "scale", Vector2(1.1, 1.1), 0.08)
    tween3.tween_property($PauseMenu/Button, "position", pos3 + Vector2(-25, -6), 0.08)
    tween3.tween_property($PauseMenu/Button, "modulate", Color(1.2, 1.2, 1.2), 0.08)
    pass # Replace with function body.


func _on_button_mouse_exited() -> void:
    if tween3: tween3.kill()
    tween3 = get_tree().create_tween().set_parallel()
    tween3.tween_property($PauseMenu/Button, "scale", Vector2(1, 1), 0.08)
    tween3.tween_property($PauseMenu/Button, "position", pos3, 0.08)
    tween3.tween_property($PauseMenu/Button, "modulate", Color(1, 1, 1), 0.08)
    
