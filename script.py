import psycopg2
import csv

# Connexion à la base
conn = psycopg2.connect(
    dbname="education",
    user="maximebarbier",
    password="@udrey29Le",
    host="localhost",
    port="5432"
)

cursor = conn.cursor()

# Exécution de la requête
cursor.execute("SELECT * FROM annuaire LIMIT 10;")

# Récupération des données
rows = cursor.fetchall()

# Récupération des noms des colonnes
colnames = [desc[0] for desc in cursor.description]

# Export vers un fichier CSV
with open('annuaire_export.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(colnames)  # écrire les en-têtes de colonnes
    writer.writerows(rows)     # écrire les lignes de données

print("Export terminé dans annuaire_export.csv")

cursor.close()
conn.close()