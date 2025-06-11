extends Node

signal scores_received(scores: Array)

var base_url := "https://apitfg-cyr0.onrender.com/api/StatsItems"
var http := HTTPRequest.new()

func _ready():
	add_child(http)
	http.request_completed.connect(_on_request_completed)

func get_scores():
	var headers = ["Content-Type: application/json"]
	var err = http.request(base_url, headers, HTTPClient.METHOD_GET)
	if err != OK:
		print("Error al solicitar la clasificación:", err)

func send_score(Name: String, puntos: int):
	var data := {
		"Name": Name,
		"Points": puntos
	}
	var json: String = JSON.stringify(data)
	var headers = ["Content-Type: application/json"]
	var err = http.request(base_url, headers, HTTPClient.METHOD_POST, json)
	if err != OK:
		print("Error al enviar la puntuación:", err)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var parsed = JSON.parse_string(body.get_string_from_utf8())
		if typeof(parsed) == TYPE_ARRAY:
			emit_signal("scores_received", parsed)
		else:
			print("Respuesta inesperada:", parsed)
	else:
		print("Error del servidor:", response_code)
