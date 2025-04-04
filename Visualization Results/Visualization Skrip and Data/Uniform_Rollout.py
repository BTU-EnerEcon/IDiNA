# -*- coding: utf-8 -*-
"""
Created on Wed Mar 12 15:45:27 2025

@author: berne
"""



import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

cm_to_inch = 0.393701
fig_width = 16 * cm_to_inch
fig_height = 10 * cm_to_inch


plt.rcParams.update({
    "font.family": "Times New Roman",
    "font.size": 9,
    "axes.titlesize": 9,
    "axes.labelsize": 9,
    "text.color": "black",
    "legend.title_fontsize": 9
})

# Daten aus der Excel-Datei einlesen
df = pd.read_excel('Uniform_Rollout.xlsx')

# Seaborn-Plot für jedes Szenario erstellen
plt.figure(figsize=(fig_width , fig_height))

# Umwandlung der "Smart Meter"-Werte in Strings
df['Smart Meter'] = df['Smart Meter'].astype(str)

#Farben der Säulen festlegen
Farben = sns.cubehelix_palette(rot=-.2)

# Erste Farbe aus der Farbpalette extrahieren
StartFarbe = Farben[0]


ax1 = sns.barplot(x='Smart Meter', y='Congestion Management Costs', data=df, color = StartFarbe ,label='Costs')
ax1.set_ylabel('Relative Costs [%]')
#,hatch='/'

# Sekundäre y-Achse erstellen und Linien für Prognosegenauigkeit darauf darstellen (für jedes Szenario separat)
ax2 = ax1.twinx()
sns.lineplot(x='Smart Meter', y='Accuracy', data=df,ax=ax2, marker='s',color='black', label='Forecast Error')
ax2.set_ylabel('Forecast Error - Standard Deviation')
# linestyle='dashed',
# Achsenbeschriftungen und Titel hinzufügen
ax1.set_xlabel('Rollout Level in [%]')
plt.title('Congestion Management Costs and Forecast Accuracy')

# Legenden-Handles und -Labels von beiden Achsen kombinieren
lines, labels = ax1.get_legend_handles_labels()
lines2, labels2 = ax2.get_legend_handles_labels()
lines += lines2
labels += labels2

# Legende anzeigen
plt.legend(lines, labels, loc='upper right')

# Diagramm als PDF speichern
#plt.savefig('Uniform_Rollout.pdf')
plt.savefig('Uniform_Rollout.svg')
# Diagramm anzeigen
plt.show()