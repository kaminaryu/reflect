extends Node

var game_running := true

func end_game() -> void :
    game_running = false
    
func reset_game() -> void :
    #for node in get_tree().get_nodes_in_group("Entities") :
        #node.queue_free()
    
    # reset singleton
    GlobalStats.player_health = 6
    GridOrganizer.used_grids.clear()
    game_running = true
