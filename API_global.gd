extends Node

var base_url := "https://apitfg-cyr0.onrender.com/api/StatsItems"
var http := HTTPRequest.new()

func _ready():
	add_child(http)

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
	print("Respuesta del servidor:", response_code)
	print("Body:", body.get_string_from_utf8())
