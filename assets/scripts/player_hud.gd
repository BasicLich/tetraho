class_name PlayerHUD
extends Control
# Heads up display to show a player's status.


# Health node.
onready var health = $Status/Offset/Health
onready var hearts = health.get_children()

# Mana nodes.
onready var mana_flask = $Status/Offset/Mana/Flask
onready var dash_ready = $Status/Offset/Mana/DashReady
onready var recharging = $Status/Offset/Mana/Recharging



# Updates the HUD based on the given player's HP.
func update_hp(player):
	var hp = player.get_hp()
	var max_hp = player.get_maximum_hp()
	
	var portion = max_hp / hearts.size() # 100 / 5 = 20
	var filled = 0
	var count = 0
	
	# Spread HP out over heart count.
	while count < hearts.size():
		var difference = hp - filled
		if difference >= portion:
			hearts[count].set_frame(0)
			filled += portion
		elif difference > 0:
			hearts[count].set_frame(1)
			filled += difference
		else:
			hearts[count].set_frame(2)
		count += 1


# Updates the HUD of the given player's dash cooldown.
func update_dash(player):
	var not_ready = player.is_on_cooldown
	mana_flask.set_frame(int(not_ready))
	dash_ready.set_visible(!not_ready)
	recharging.set_visible(not_ready)
	