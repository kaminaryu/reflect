extends Node2D

var death_pos:Vector2
var total_time:float = 0.0
var corners_pos:Dictionary
var max_time := 3.0
var min_health := 3
var max_health := 5

@onready var bug_scn = preload("res://Objects/Bugs/bug.tscn")

func init_spawner(goal_coords:Vector2, end_coords:Vector2, paths:Dictionary) -> void :
    position = paths[goal_coords].pos
    death_pos = paths[end_coords].pos
    get_corners(paths)

    
func get_corners(paths) :
    var current_dir = 1
    corners_pos.clear()
    
    for path_coords in paths :
        var path:Dictionary = paths[path_coords]
        
        # if theres a different in direction
        #if path.dir > current_dir :
            #corners_pos[path.pos] = 1
            #current_dir = path.dir
        #
        #elif path.dir < current_dir :
            #corners_pos[path.pos] = -1
            #
            #current_dir = path.dir
            
        if path.turn_to :
            #print("corner lol at ", path.pos)
            corners_pos[path.pos] = path.turn_to
    
var raised = false
func _process(delta: float) -> void:
    if not Brain.game_running :
        return
#        
    if GlobalStats.player_score % 150 && GlobalStats.player_score > 0 and not raised :
        raised = true
        max_time -= 0.25
        min_health += 1
        max_health += 2
    elif GlobalStats.player_score % 150 == 1 :
        raised = false
        
        
    total_time += delta

    if total_time > max_time + randi_range(-0.3, 0) :
        print("skdiaj")
        total_time = 0.0
        
        var bug = bug_scn.instantiate()
        bug.position = global_position
        bug.corners_pos = corners_pos
        bug.death_pos = death_pos
        bug.health = randi_range(min_health, max_health)
        var scale_factor = randf_range(0.7, 1.3)
        bug.scale = Vector2(scale_factor, scale_factor)
        
        bug.add_to_group("Bugs")
        get_tree().current_scene.add_child(bug)
        
        
