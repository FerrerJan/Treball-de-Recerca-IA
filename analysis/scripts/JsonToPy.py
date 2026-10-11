import json
from os import listdir
import os

# Rutes relatives a l'arrel del repositori
ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
ruta_json = os.path.join(ROOT, 'game', 'Dades_Json')
ruta_txt = os.path.join(ROOT, 'analysis', 'data')
os.makedirs(ruta_txt, exist_ok=True)
archivos = listdir(ruta_json)

for archivo in archivos:
    if archivo.endswith('.json'):
        datos_txt = ''
        with open(os.path.join(ruta_json, archivo), 'r') as archivo_json:
            datos_json = json.load(archivo_json)

        for partida in datos_json.get('partides', []):
            for generacio in partida.get('generacions', []):
                datos_txt += str(generacio.get('fitness', '')) + ', '
            datos_txt += '\n'
        
        nombre_txt = archivo.replace('.json', '.txt')
        
        with open(os.path.join(ruta_txt, nombre_txt), 'w') as archivo_txt:
            archivo_txt.write(datos_txt)
