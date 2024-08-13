import json
from os import listdir
import os

ruta_json = 'C:\\Users\\07map\\Documents\\GitHub\\Flappy-bird_TR\\JOCS\\Flappy-bird_TR\\Dades_Json\\'
ruta_txt = 'C:\\Users\\07map\\Documents\\GitHub\\Flappy-bird_TR\\TR\\DATOS\\'
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
