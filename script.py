import psycopg2

conn = psycopg2.connect(
    dbname="education",
    user="postgres",
    password="@udrey29Le",
    host="localhost",
    port="5432"
)

cursor = conn.cursor()
cursor.execute("SELECT version();")
print(cursor.fetchone())

cursor.close()
conn.close()
