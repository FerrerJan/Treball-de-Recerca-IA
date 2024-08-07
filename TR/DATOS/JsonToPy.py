import json
from os import listdir

ruta_json = 'C:\\Users\\07map\\Documents\\GitHub\\Flappy-bird_TR\\JOCS\\Flappy-bird_TR\\Dades Json\\'
archivos = listdir(ruta_json)
print(ruta_json, archivos)

for archivo in archivos:
    datos_txt = ''
    with open(ruta_json + archivo, 'r') as archivo:
        datos_json = json.load(archivo)

    for partida in datos_json['partides']:
        for generacio in partida['generacions']:
            datos_txt += str(generacio['fitness']) + ', '
        datos_txt += '\n'
    nombre_txt = str(archivo)
    
    with open(nombre_txt.replace('.json', '.txt'), 'w') as archivo:
        archivo.write(datos_txt)
