import csv
import os
import pandas as pd

def get_csv_files(path):
    csv_files = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith('.csv'):
                csv_files.append(os.path.join(root, file))
    return csv_files

path = r'C:\Users\Max Bernecker\Desktop\Zähler_2018\output'
files = get_csv_files(path)

df_list = []

for file in files:
    with open(file, 'r') as f:
        reader = csv.reader(f)
        header = next(reader)
        file_data = [float(row[1]) for row in reader]
        column_name = os.path.splitext(os.path.basename(file))[0][-5:]
        df_list.append(pd.DataFrame({column_name: file_data}))

df = pd.concat(df_list, axis=1)
df.to_excel('Combined.xlsx', index=False)




