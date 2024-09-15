import os
import re

# Ruta a la carpeta que contiene los archivos de texto
carpeta = r'C:\Users\07map\Documents\GitHub\Flappy-bird_TR\JOCS\Flappy-bird_TR\Dades\no monedes'

# Inicializar la variable npartides
npartides = 0

# Expresión regular para buscar la línea con "Partides totals: "
patron = re.compile(r'Partides totals: (\d+)')

# Recorrer todos los archivos en la carpeta
for archivo in os.listdir(carpeta):
    if archivo.endswith('.txt'):
        ruta_archivo = os.path.join(carpeta, archivo)
        with open(ruta_archivo, 'r', encoding='utf-8') as f:
            for linea in f:
                # Buscar la línea que contiene "Partides totals: "
                coincidencia = patron.search(linea)
                if coincidencia:
                    # Extraer el número y sumarlo a npartides
                    numero = int(coincidencia.group(1))
                    npartides += numero

# Mostrar el resultado final
print(f'Total de partidas: {npartides}')
