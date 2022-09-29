import pymysql

def mysql_connect():
    con = pymysql.connect(host='team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com', user='admin', password='p83YoUoffEo0xChEq9kG', db='Team26Database')

    cur = con.cursor()
    cur.execute('select * from Catalog')
    output = cur.fetchall()

    print(output)
    con.close()

if __name__ == '__main__':
    mysql_connect()