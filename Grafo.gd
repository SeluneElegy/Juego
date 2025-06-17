extends Node

class_name Grafo

var nodos = {}
var conexiones = {}

func agregar_nodo(id: String, posicion: Vector2) -> void:
	nodos[id] = posicion
	conexiones[id] = []

func conectar(id1: String, id2: String) -> void:
	if id1 in conexiones and id2 in conexiones:
		conexiones[id1].append(id2)
		conexiones[id2].append(id1)

func heuristica(a: String, b: String) -> float:
	return nodos[a].distance_to(nodos[b])

func encontrar_mas_cercano(pos: Vector2) -> String:
	var mas_cercano = ""
	var menor_dist = INF
	for id in nodos:
		var dist = nodos[id].distance_to(pos)
		if dist < menor_dist:
			menor_dist = dist
			mas_cercano = id
	return mas_cercano

func buscar_ruta(inicio: String, destino: String) -> Array:
	var abiertos = [inicio]
	var de_donde_vengo = {}
	var costo_hasta = {inicio: 0}
	var puntaje_estimado = {inicio: heuristica(inicio, destino)}

	while abiertos.size() > 0:
		var actual = abiertos[0]
		for n in abiertos:
			if puntaje_estimado.get(n, INF) < puntaje_estimado.get(actual, INF):
				actual = n
		if actual == destino:
			var ruta = [actual]
			while actual in de_donde_vengo:
				actual = de_donde_vengo[actual]
				ruta.insert(0, actual)
			return ruta

		abiertos.erase(actual)
		for vecino in conexiones[actual]:
			var nuevo_costo = costo_hasta[actual] + nodos[actual].distance_to(nodos[vecino])
			if vecino not in costo_hasta or nuevo_costo < costo_hasta[vecino]:
				costo_hasta[vecino] = nuevo_costo
				puntaje_estimado[vecino] = nuevo_costo + heuristica(vecino, destino)
				de_donde_vengo[vecino] = actual
				if vecino not in abiertos:
					abiertos.append(vecino)

	return []func _ready():
	# Cargar nodos para cubrir área 1280x720 aprox.
	agregar_nodo("A", Vector2(100, 100))
	agregar_nodo("B", Vector2(640, 100))
	agregar_nodo("C", Vector2(1180, 100))
	agregar_nodo("D", Vector2(100, 360))
	agregar_nodo("E", Vector2(640, 360))
	agregar_nodo("F", Vector2(1180, 360))
	agregar_nodo("G", Vector2(100, 640))
	agregar_nodo("H", Vector2(640, 640))
	agregar_nodo("I", Vector2(1180, 640))

	conectar("A", "B")
	conectar("B", "C")
	conectar("A", "D")
	conectar("B", "E")
	conectar("C", "F")
	conectar("D", "E")
	conectar("E", "F")
	conectar("D", "G")
	conectar("E", "H")
	conectar("F", "I")
	conectar("G", "H")
	conectar("H", "I")
