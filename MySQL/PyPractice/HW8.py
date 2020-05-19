import pymysql
import databaseconfig as cfg

# connects to the database
conn = pymysql.connect(cfg.mysql['server'], cfg.mysql['user'], cfg.mysql['password'], cfg.mysql['database'])
if conn:
    print('Connection to MySQL database', cfg.mysql['database'], 'was successful!')

with conn:

    cur = conn.cursor()
    cur.execute("SELECT * FROM Books")

    rows = cur.fetchall()

    for row in rows:
        print("{0} {1} {2}".format(row[0], row[1], row[2]))

# closes the connection
print('Bye!')
conn.close()
