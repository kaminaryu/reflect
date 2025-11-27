extends Node2D

var death_pos:Vector2
var total_time:float = 0.0
var corners_pos:Dictionary

@onready var bug_scn = preload("res://Objects/Bugs/bug.tscn")
@onready var marker_scn = preload("res://Objects/debugs/marker.tscn")

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
    

func _process(delta: float) -> void:
    total_time += delta

    if total_time > 1 :
        total_time = 0.0
        
        var bug = bug_scn.instantiate()
        bug.position = global_position
        bug.corners_pos = corners_pos
        bug.death_pos = death_pos
        bug.add_to_group("Bugs")
        get_tree().current_scene.add_child(bug)
        
        
