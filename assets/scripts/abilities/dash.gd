class_name Dash
extends Ability
# Temporary. Just testing.


# Direction of dash.
var direction : Vector2
# Speed of dash.
export var speed = 4
# Cooldown bonus if an enemy is hit by the dash.
export var cooldown_bonus : float


func _physics_process(delta):
	if is_active:
		# Move towards dash direction until dash duration is gone.
		countdown -= delta
		if countdown > 0:
			var collision = caster.move_and_collide(direction * speed)
			# If collided with an enemy, knock it back and reset dash.
			if collision:
				var body = collision.get_collider()
				if body.is_in_group("enemy") and not body.is_locked():
					var knockback = Knockback.new()
					knockback.direction = direction
					knockback.duration = duration
					body.add_child(knockback)
					complete()
					delay -= cooldown_bonus
					
		else:
			complete()


func complete():
	.complete()
	update()


func reset():
	.reset()
	direction = Vector2.ZERO
	update()


func update():
	if caster.hud:
		caster.hud.update_dash(self)
