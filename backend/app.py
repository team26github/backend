from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
import pymysql

app = Flask(__name__)
app.config.from_object(__name__)
db = pymysql.connect(host='team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com', user='admin', password='p83YoUoffEo0xChEq9kG', database='Team26Database')

CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)

@app.route('/login', methods=['GET', 'POST'])
def login():
    username = request.args['username']
    password = request.args['password']

    cursor = db.cursor()
    query = f'SELECT * FROM UserInfo where (Username = "{username}" AND Passwd = "{password}");'
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

@app.route('/edit', methods=['GET', 'POST'])
@cross_origin()
def edit():
    cursor = db.cursor()
    if request.method == 'GET':
        if request.args.get('request', '') == 'email':
            email = request.args.get('email', '')
            query = f'SELECT Email from UserInfo where Email = "{email}"'
            cursor.execute(query)
            results = cursor.fetchall()
            if len(results) > 0:
                return jsonify({'status': 'failure'})
            else:
                return jsonify({'status': 'success'})
        elif request.args.get('request', '') == 'username':
            username = request.args.get('username', '')
            query = f'SELECT Username from UserInfo where Username = "{username}"'
            cursor.execute(query)
            results = cursor.fetchall()
            if len(results) > 0:
                return jsonify({'status': 'failure'})
            else:
                return jsonify({'status': 'success'})
        return jsonify({'status', 'failure'})
    elif request.method == 'POST':
        status = 'failure'

        if request.args.get('request', '') == 'email':
            email = request.args.get('email', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET Email = "{email}"
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            status = 'success'

        elif request.args.get('request', '') == 'username':
            username = request.args.get('username', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET Username = "{username}"
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            status = 'success'

        elif request.args.get('request', '') == 'password':
            password = request.args.get('password', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET Email = "{password}"
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            status = 'success'

        return jsonify({'status': status})


if __name__ == '__main__':
    app.run(debug=True)