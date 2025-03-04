import os
os.environ["PATH"] += os.pathsep + r"C:\Program Files\Graphviz\bin"

import graphviz
from IPython.display import Image, display

def generate_flowchart():
    dot = graphviz.Digraph()
    
    # Start
    dot.node('A', 'Start')
    
    # Input Daten
    dot.node('B', 'Input Netzwerkdaten')
    dot.edge('A', 'B')
    
    # Rolling Horizon Start
    dot.node('C', 'Start Rolling Horizon')
    dot.edge('B', 'C')
    
    # Initialisierung Tag H
    dot.node('D', 'Initialisierung Tag H')
    dot.node('D1', 'Input Stromerzeugungsprofile')
    dot.node('D2', 'Input Power Flows & Voltage Levels')
    dot.node('D3', 'Input Sensitivitätsfaktoren')
    dot.edge('C', 'D')
    dot.edge('D', 'D1')
    dot.edge('D', 'D2')
    dot.edge('D', 'D3')
    
    # Engpassmanagement
    dot.node('E', 'Engpassmanagement für Tag H')
    dot.edge('D1', 'E')
    dot.edge('D2', 'E')
    dot.edge('D3', 'E')
    
    # Check Bedingung
    dot.node('F', 'Check: Tag H = Max Tage?')
    dot.edge('E', 'F')
    
    # Entscheidung
    dot.node('G', 'Ja: Ende Rolling Horizon', shape='parallelogram')
    dot.node('H', 'Nein: Tag H = Tag H +1')
    dot.edge('F', 'G', label='Ja')
    dot.edge('F', 'H', label='Nein')
    dot.edge('H', 'C')  # Zurück zum Rolling Horizon
    
    # Ausgabe und Analyse
    dot.node('I', 'Ausgabe der Daten & Analyse', shape='parallelogram')
    dot.edge('G', 'I')
    
    return dot

# Generiere und zeige den Flowchart im Jupyter Notebook
dot = generate_flowchart()
dot.render('stromengpass_flowchart', format='png', cleanup=False)
display(Image(filename='stromengpass_flowchart.png'))
