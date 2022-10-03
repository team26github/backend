from flask import Flask, jsonify, request
from flask_cors import CORS
import pymysql

DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)
db = pymysql.connect(host='team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com', user='admin', password='p83YoUoffEo0xChEq9kG', database='Team26Database')

CORS(app, resources={r'/*': {'origins': '*'}})

login_info = {'username': '', 'password': ''}

@app.route('https://spacebarcowboysbackend.herokuapp.com/login', methods=['GET', 'POST'])
def login():


    login_info['username'] = request.args['username']
    login_info['password'] = request.args['password']

    cursor = db.cursor()
    query = f'SELECT * FROM UserInfo where (Username = "{login_info["username"]}" AND Passwd = "{login_info["password"]}");'
    cursor.execute(query)
    results = cursor.fetchall()

    if len(results) > 0:
        return jsonify({
            'status': 'success',
            'results': results
        })
    else:
        return jsonify({
            'status': 'failure',
            'results': results
        })


if __name__ == '__main__':
    app.run()