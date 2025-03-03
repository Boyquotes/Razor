class_name Object_climbable
extends Node3D

##
## Climbable Object
##
## @desc:
##     This script adds climbing support to any StaticBody3D.
##
##     For climbing to work, the player must have a Function_Climb_movement.
##

var press_to_hold := true

## Dictionary of grab locations by pickup
var grab_locations := {}

# Called by Function_pickup
func is_picked_up() -> bool:
	return false

func can_pick_up(_by: Node3D) -> bool:
	return true

# Called by Function_pickup when user presses the action button while holding this object
func action():
	pass

# Called by Function_pickup when this becomes the closest object to a controller
func increase_is_closest():
	pass

# Called by Function_pickup when this stops being the closest object to a controller
func decrease_is_closest():
	pass

# Called by Function_pickup when this is picked up by a controller
func pick_up(by: Node3D, with_controller: XRController3D) -> void:
	save_grab_location(by)

# Called by Function_pickup when this is let go by a controller
func let_go(p_linear_velocity: Vector3, p_angular_velocity: Vector3) -> void:
	pass

# Save the grab location
func save_grab_location(p: Node3D):
	grab_locations[p.get_instance_id()] = to_local(p.global_transform.origin)

# Get the grab location in world-space
func get_grab_location(p: Node3D) -> Vector3:
	return to_global(grab_locations[p.get_instance_id()])
