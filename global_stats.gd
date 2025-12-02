extends Node

var player_health := 6
var player_score := 0
var player_money := 10
var sonar_energy := 4

var total_time := 0.0

func decrease_health() -> void:
    player_health -= 1
    
    if player_health < 1 :
        get_tree().root.get_node("/root/Main/GameOver").play()
        await get_tree().create_timer(1).timeout
        Brain.end_game()
    else :
        get_tree().root.get_node("/root/Main/Hurt").play()
        
func _process(delta: float) -> void:
    total_time += delta 
    
    if total_time > 0.5 :
        total_time = 0
        sonar_energy += 1
