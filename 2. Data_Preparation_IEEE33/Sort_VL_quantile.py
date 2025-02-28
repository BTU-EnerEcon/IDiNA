import pandas as pd
import os

# Pfad zu den Excel-Dateien
path = r"put here the path to the simulated voltage levels"

# Liste der Excel-Dateien in dem Ordner
files = [f for f in os.listdir(path) if f.endswith(".xlsx")]

# Schleife über jede Excel-Datei
for file in files:
    # Lese die Excel-Datei in einen Pandas DataFrame ein
    df = pd.read_excel(os.path.join(path, file))

    # Gruppiere die Daten nach der Spalte für die Leitung oder den Bus(Knoten)
    grouped = df.groupby("B")

    # Erstelle eine leere Liste, um die Ergebnisse aufzunehmen
    results = []


    # Schleife über jede Gruppe (jede Leitung)
    for name, group in grouped:
        # Berechnet das Minimum und Maximum für jede Spalte (Zeit)
        min_values = group.iloc[:, 2:].min(axis=0)
        max_values = group.iloc[:, 2:].max(axis=0)

        # Berechne das x%-Quantil für negative Werte und das 1-x%-Quantil für positive Werte
        quantiles = pd.concat([group.iloc[:, 2:].quantile(q=0.01).where(min_values < 0, other=group.iloc[:, 2:].quantile(q=0.99)),
                               group.iloc[:, 2:].quantile(q=0.99).where(max_values > 0, other=group.iloc[:, 2:].quantile(q=0.01))])

        # Füge die Ergebnisse in ein neues DataFrame ein
        result = pd.DataFrame(quantiles.to_dict(), index=[name])
        results.append(result)

    #Fügt alle Ergebnisse in ein gemeinsames DataFrame ein
    output = pd.concat(results, axis=0)

    # Schreibe das Ergebnis in eine Excel-Datei
    output.to_excel(os.path.join(path, f"result_{os.path.splitext(file)[0]}.xlsx"), index=True)
 

    