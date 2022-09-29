from flask import Flask, jsonify, request
from flask_cors import CORS
from flaskext.mysql import MySQL #pip install flask-mysql
import pymysql

DEBUG = True
 
# instantiate the app
dbapp = Flask(__name__)
dbapp.config.from_object(__name__)
     
mysql = MySQL()
    
dbapp.config['MYSQL_DATABASE_USER'] = 'admin'
dbapp.config['MYSQL_DATABASE_PASSWORD'] = 'p83YoUoffEo0xChEq9kG'
dbapp.config['MYSQL_DATABASE_DB'] = 'Team26Database'
dbapp.config['MYSQL_DATABASE_HOST'] = 'team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com'
mysql.init_app(dbapp)

CORS(dbapp, resources={r'/*': {'origins': '*'}})

@dbapp.route('/')
def home():
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    try:
        cursor.execute("SELECT * from Catalog")
        catalog_list = cursor.fetchall()
        return jsonify({
            'status': 'success',
            'catalog_list': catalog_list
        })
    except Exception as e:
        print(e)
    finally:
        cursor.close() 
        conn.close()

if __name__ == '__main__':
    dbapp.run()