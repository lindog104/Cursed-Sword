extends CanvasLayer

## Temptation Game Passdown
#
# Passes down the call for the Temptation Game

func play_minigame(speedup_modifier: float) -> bool:
	return await $TemptGame.play_minigame(speedup_modifier)
