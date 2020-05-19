import pymysql

server = 'localhost'
database = 'xyz'
user = 'xyz'
password = '024680'

# connects to the database
conn = pymysql.connect(server, user, password, database)
if conn:
    print('Connection to MySQL database', database, 'was successful!')

# closes the connection
print('Bye!')
conn.close()
