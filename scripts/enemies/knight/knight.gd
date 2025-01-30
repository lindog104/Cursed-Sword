extends Peasant

## Knight Control Script
#
# Acts just like a Peasant but casts Shield whenever it can

@onready var spell_component: SpellComponent = $SpellComponent

# Called when the scene enters the scene tree for the first time
func _ready() -> void:
	# Cast the spell to start
	spell_component.cast_spell()

# Triggered by the SpellTimer timeout
func on_spell_timeout() -> void:
	# Attempt to cast a spell
	spell_component.cast_spell()
