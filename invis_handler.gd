extends Node2D

#@onready var tween = create_tween()
var playing_anim := false
@export var enabled := true
@export var reversed := false

func _ready() -> void:
    if not enabled :
        return
        
    get_parent().add_to_group("Objects")
    if reversed :
        get_parent().modulate.a = 1.0
    else :
        get_parent().modulate.a = 0.0
    
    
func toggle_visible() -> void :
    print("hello ", get_parent().visible, "  |  ", get_parent().modulate)
    get_parent().visible = true
    showing()
    
    
func showing() -> void :
    if playing_anim :
        return
        
    playing_anim = true
    
    
    if reversed :
        var x := 1.0
        while x > 0.0 :
            x -= 0.5 * (x + 0.1)
            get_parent().modulate.a = x
            await get_tree().create_timer(0.05).timeout
            
        await get_tree().create_timer(1).timeout # staying visible
        
        while x < 1.0 :
            x += 0.5 * (x + 0.1)
            get_parent().modulate.a = x
            await get_tree().create_timer(0.05).timeout
            
    else :
        var x := 0.0
        while x < 1.0 :
            x += 0.5 * (x + 0.1)
            get_parent().modulate.a = x
            await get_tree().create_timer(0.05).timeout
            
        await get_tree().create_timer(1).timeout #staying visible
        
        while x > 0.0 :
            x -= 0.5 * (x + 0.1)
            get_parent().modulate.a = x
            await get_tree().create_timer(0.05).timeout
            
    playing_anim = false
        
