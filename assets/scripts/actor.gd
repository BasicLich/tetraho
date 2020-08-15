class_name Actor
extends KinematicBody2D
# An actor that can perform actions in the game.


# Hit points.
var hp = 100
# Speed in which the actor can move.
var move_speed = 1


# Checks if actor is dead.
func is_dead():
	return hp <= 0


# Damage the actor.
func oof(damage):
	hp -= damage
