# ts an singleton / autoload
extends Node2D

var selected_turret_scn
var turret_index := -1
var prices := [5, 7, 12]

@onready var crystal_scn = preload("res://Objects/Turrets/crystal.tscn")
@onready var twin_scn    = preload("res://Objects/Turrets/twin.tscn")
@onready var arch_scn    = preload("res://Objects/Turrets/arch.tscn")

func buy_turret(index:int) -> void :
    if GlobalStats.player_money < prices[index] :
        return
    turret_index = index
    
func _unhandled_input(evt: InputEvent) -> void :
    #if evt is InputEventKey :
        #if evt.pressed :
            #if evt.keycode == KEY_1 :
                #selected_turret_scn = arch_scn
            #elif evt.keycode == KEY_2 :
                #selected_turret_scn = twin_scn
            #else :
                #return
                
    if evt is InputEventMouseButton :
        if evt.pressed and evt.button_index == MOUSE_BUTTON_LEFT :
            var mouse_pos = get_global_mouse_position().snapped(Vector2(128, 128))
            
            if GridOrganizer.is_in_used_grid(mouse_pos) :
                return
                
                
            if turret_index == 0 :
                selected_turret_scn = crystal_scn
            elif turret_index == 1 :
                selected_turret_scn = twin_scn
            elif turret_index == 2 :
                selected_turret_scn = arch_scn
            else :
                return
                
            
                
            
            var turret = selected_turret_scn.instantiate()
            turret.scale = Vector2(0.9, 0.9)
            turret.position = mouse_pos
            get_tree().current_scene.add_child(turret)
            GridOrganizer.add_to_grid(mouse_pos)
            
            GlobalStats.player_money -= prices[turret_index]
            
            
            turret_index = -1
            
            

            
    
