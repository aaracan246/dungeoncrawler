extends Label

func _ready() -> void:
	text = str(ScoreManager.get_score())

	if not ScoreManager.is_connected("score_changed", Callable(self, "_on_score_changed")):
		ScoreManager.score_changed.connect(_on_score_changed)
		
func _on_score_changed(new_score: int) -> void:
	text = str(new_score)
