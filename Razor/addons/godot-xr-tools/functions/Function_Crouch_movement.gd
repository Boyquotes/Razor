@tool
class_name Function_CrouchMovement
extends MovementProvider

##
## Movement Provider for Crouching
##
## @desc:
##     This script works with the PlayerBody attached to the players XROrigin3D.
##
##     When the player presses the selected button, the height is overridden
##     to the crouch height
##


# enum our buttons, should find a way to put this more central
enum Buttons {
	VR_BUTTON_BY = 1,
	VR_GRIP = 2,
	VR_BUTTON_3 = 3,
	VR_BUTTON_4 = 4,
	VR_BUTTON_5 = 5,
	VR_BUTTON_6 = 6,
	VR_BUTTON_AX = 7,
	VR_BUTTON_8 = 8,
	VR_BUTTON_9 = 9,
	VR_BUTTON_10 = 10,
	VR_BUTTON_11 = 11,
	VR_BUTTON_12 = 12,
	VR_BUTTON_13 = 13,
	VR_PAD = 14,
	VR_TRIGGER = 15
}


## Movement provider order
@export var order := 10

## Crouch height
@export var crouch_height := 1.0

## Crouch button
@export (Buttons) var crouch_button: int = Buttons.VR_PAD


## Crouching flag
var _crouching := false


# Controller node
@onready var _controller : XRController3D = get_parent()


# Perform jump movement
func physics_movement(delta: float, player_body: PlayerBody, _disabled: bool):
	# Skip if the controller isn't active
	if !_controller.get_is_active():
		return

	# Check for crouching change
	var crouching := _controller.is_button_pressed(crouch_button) != 0
	if crouching == _crouching:
		return
	
	# Update crouching state
	_crouching = crouching
	if crouching:
		player_body.override_player_height(self, crouch_height)
	else:
		player_body.override_player_height(self)


# This method verifies the MovementProvider has a valid configuration.
func _get_configuration_warnings():
	# Check the controller node
	var test_controller = get_parent()
	if !test_controller or !test_controller is XRController3D:
		return "Unable to find ARVR Controller node"

	# Call base class
	return super._get_configuration_warnings()
