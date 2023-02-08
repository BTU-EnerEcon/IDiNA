# Dieser Code soll aus den sotrierten .csv Dateien der Stadtwerke (Soriertung der einzelnen SM nach Station (Ornder)) die SM herauslesen, welche "Null Werte" haben

import pandas as pd
import os

# Pfad zu dem Hauptordner, in dem die georndeten Stationen mit den jeweiligen SM gespeichert sind
main_path = r'C:\Users\Max Bernecker\Desktop\Zähler_2018\output'

# Pfad zu dem neuen Ordner "Leer", welcher die "Null Profile" beinhalten soll
empty_path = r'C:\Users\Max Bernecker\Desktop\Zähler_2018\empty'

# Durchläuft alle Unterordner im Hauptordner
for sub_folder in os.listdir(main_path):
    sub_folder_path = os.path.join(main_path, sub_folder)
    if os.path.isdir(sub_folder_path):
        # Ließt alle .csv-Dateien im Unterordner ein
        files = [f for f in os.listdir(sub_folder_path) if f.endswith('.csv')]
        for file in files:
            df = pd.read_csv(os.path.join(sub_folder_path, file))
            # Hier ist der Standard-Spaltenname der zweiten Spalte (in der die Lastwerte gespeichert sind) des df Data Frames (SM csv. Datei) "0" (von den Stadtwerken eingestellt)
            if (df['0'] == 0).sum() >= 48:
                os.rename(os.path.join(sub_folder_path, file), os.path.join(empty_path, file))

