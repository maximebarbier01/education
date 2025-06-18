import psycopg2

conn = psycopg2.connect(
    dbname="education",
    user="maximebarbier",
    password="@udrey29Le",
    host="localhost",
    port="5432"
)

cursor = conn.cursor()
cursor.execute("SELECT * FROM annuaire LIMIT 1;")
print(cursor.fetchall())
cursor.close()
conn.close()