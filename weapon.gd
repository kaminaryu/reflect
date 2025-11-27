extends Node2D

@export var delay: float

@onready var bulletScn := preload("res://Objects/Components/bullet.tscn")

var totalTime:float = 0.0
var shooting := false

func _ready() -> void:
    visible = false
    
func _process(delta: float) -> void:
    if not shooting :
        totalTime = delay
        return 
        
    totalTime += delta

    if totalTime > delay :
        totalTime = 0.0
        
        var bullet := bulletScn.instantiate()
        get_tree().current_scene.add_child(bullet)
        
        bullet.global_position = global_position
        bullet.direction = Vector2.RIGHT.rotated(get_parent().rotation)
    
        #print("New bullet spawned"); print(get_parent().rotation)
        #print(global_position, bullet.global_position)
        
        
