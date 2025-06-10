extends Control

@onready var texto_izq := $MarginContainer1/RichTextLabelLeft
@onready var texto_der := $MarginContainer2/RichTextLabelRight

var bloques := [
	"""Hace quinientos años, el Reino de Dungard se salvó de la oscuridad.""",

"""Un héroe legendario selló la mazmorra, un laberinto sin fin del que emergen oscuras criaturas.""",

"""Pero el sello se debilita... y la rueda del tiempo ha vuelto a girar...""",

	"""El rey ha convocado a caballeros, mercenarios y aventureros de todas partes.""",

"""Quien logre sellarla de nuevo, obtendrá riquezas, honor... y una historia que contar.""",

"""Pero nadie ha regresado del laberinto.
""",
	"""Tú no buscas la gloria.

Buscas la recompensa.""",

"""Así que te adentras en la mazmorra...
"""
]

var bloque_actual := 0
var velocidad := 0.05
var escribiendo := false
var salto_escritura := false

func _ready():
	texto_izq.clear()
	texto_der.clear()
	mostrar_bloque()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed or event.is_action_pressed("ui_accept"):
		if escribiendo:
			salto_escritura = true
		else:
			avanzar_bloques()

func mostrar_bloque():
	if bloque_actual >= bloques.size():
		LoadingScreen.load_scene_async("res://scenes/ui.tscn")
		return

	var label := texto_izq if bloque_actual % 2 == 0 else texto_der
	var otro_label := texto_der if label == texto_izq else texto_izq

	label.clear() 
	escribiendo = true
	salto_escritura = false
	await escribir(label, bloques[bloque_actual])
	escribiendo = false

func avanzar_bloques():
	bloque_actual += 1
	mostrar_bloque()

func escribir(label: RichTextLabel, texto_completo: String) -> void:
	label.clear()
	var i := 0
	while i < texto_completo.length():
		if salto_escritura:
			label.text = texto_completo
			return
		label.append_text(texto_completo[i])
		await get_tree().create_timer(velocidad).timeout
		i += 1
