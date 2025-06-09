extends Control

@onready var texto_izq := $MarginContainer1/RichTextLabelLeft
@onready var texto_der := $MarginContainer2/RichTextLabelRight

var bloques := [
	"""Hace quinientos años, el Reino de Dungard se salvó de la oscuridad.

Un héroe legendario selló la mazmorra, un laberinto sin fin del que emergen criaturas que solo traen desolación.

Pero el sello se debilita... y la rueda del tiempo ha vuelto a girar...
""",
	"""El rey ha convocado a caballeros, mercenarios y aventureros de todas partes.

Quien logre sellarla de nuevo, obtendrá riquezas, honor... y una historia que sobrevivirá al tiempo.

Pero nadie ha regresado del laberinto.
""",
	"""Tú no buscas la gloria.

Buscas la recompensa.

Así que te adentras en la mazmorra...
"""
]

var bloque_actual := 0
var indice := 0
var velocidad := 0.05
var escribiendo := false

func _ready():
	mostrar_bloques()

func _unhandled_input(event):
	if escribiendo:
		return

	if event is InputEventMouseButton and event.pressed or event.is_action_pressed("ui_accept"):
		avanzar_bloques()

func mostrar_bloques():
	escribiendo = true
	texto_izq.clear()
	texto_der.clear()
	indice = 0

	match bloque_actual:
		0:
			await escribir(texto_izq, bloques[0])
			await escribir(texto_der, bloques[1])
			escribiendo = false
		1:
			await escribir(texto_izq, bloques[2])
			escribiendo = false
		_:
			escribiendo = false

func avanzar_bloques():
	bloque_actual += 1
	if bloque_actual < 2:
		mostrar_bloques()
	else:
		LoadingScreen.load_scene_async("res://scenes/ui.tscn")

func escribir(label: RichTextLabel, texto_completo: String) -> void:
	for i in texto_completo:
		label.append_text(i)
		await get_tree().create_timer(velocidad).timeout
