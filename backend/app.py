from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from datetime import datetime
import pymysql
import json

app = Flask(__name__)
app.config.from_object(__name__)
db = pymysql.connect(host='team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com', user='admin', password='p83YoUoffEo0xChEq9kG', database='Team26Database')

CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)
'''
def get_new_token():
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ...'
    }

    body = {
        'grant_type': 'client_credentials',
        'scope': 'https://api.ebay.com/oauth/api_scope'
    }

    res = requests.post(TOKEN_URL, headers=headers, data=body)
    data = json.loads(res.content)
    global EBAY_TOKEN
    EBAY_TOKEN = data['access_token']
    global EXPIRES
    EXPIRES = datetime.datetime.now() + datetime.timedelta(seconds=7200)
'''

@app.route('/login', methods=['GET', 'POST'])
def login():
    username = request.args['username']
    password = request.args['password']

    if request.method == 'GET':
        cursor = db.cursor()
        query = f'SELECT * FROM UserInfo where (Username = "{username}" AND Passwd = "{password}");'
        cursor.execute(query)
        results = cursor.fetchall()

    if len(results) > 0:
        status='success'
        mycursor1 = db.cursor()
        mycursor2 = db.cursor()

        sql1 = f'SELECT UserID from UserInfo where Username ="{username}"'
        mycursor1.execute(sql1)
        result = mycursor1.fetchall()
        sql2 = "INSERT INTO Login (UserID, UsernameAttempted, PasswordAttempted, LoginSuccessful, LoginTime) VALUES (%s, %s, %s, %s, %s)"
        val2 = [
            ({result},{username}, {password}, f'{status}', datetime.now())
        ]
        mycursor2.executemany(sql2, val2)
        db.commit()
        
        return jsonify({
            'status': status,
            'results': results
        })
    else:
        status='failure'
        mycursor=db.cursor()

        sql = "INSERT INTO Login (UsernameAttempted, PasswordAttempted, LoginSuccessful, LoginTime) VALUES (%s, %s, %s, %s)"
        val = [
            ({username}, {password}, f'{status}', datetime.now())
        ]
        mycursor.executemany(sql, val)
        db.commit()
        return jsonify({
            'status': status,
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
            print("UserID: "+userid+" Email:"+email)
            query = f'UPDATE UserInfo SET Email = "{email}" WHERE UserID = {userid}'
            cursor.execute(query)
            db.commit()
            status = 'success'

        elif request.args.get('request', '') == 'username':
            username = request.args.get('username', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET Username = "{username}"
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            db.commit()
            status = 'success'

        elif request.args.get('request', '') == 'password':
            password = request.args.get('password', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET Passwd = "{password}"
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            db.commit()
            status = 'success'
            
        elif request.args.get('request', '') == 'max_points':
            max_points = request.args.get('max_points', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET PointsLimit = {max_points}
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            db.commit()
            status = 'success'

        elif request.args.get('request', '') == 'expiration_period':
            expiration_period = request.args.get('expiration_period', '')
            userid = request.args.get('userid', '')
            query = f'''UPDATE UserInfo
                        SET ExpirationPeriod = "{expiration_period}"
                        WHERE UserID = {userid}'''
            cursor.execute(query)
            db.commit()
            status = 'success'

        return jsonify({'status': status})

@app.route('/userinfo', methods=['GET'])
def get_user_info():
    username = request.args.get('username', '')
    cursor = db.cursor()
    query = f'SELECT * FROM UserInfo WHERE Username = "{username}"'
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

@app.route('/get-drivers', methods=['GET'])
@cross_origin()
def get_drivers():
    user_id = request.args['user_id']
    cursor = db.cursor()
    
    query = f'SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) FROM UserInfo WHERE UserType = "Driver" AND SPONSOR_ID = "{user_id}"'
    
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

@app.route('/get-sponsors', methods=['GET'])
def get_sponsors():
    cursor = db.cursor()
    query = f'SELECT Username FROM UserInfo WHERE UserType = "Sponsor"'
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


@app.route('/apply', methods=['POST'])
@cross_origin()
def apply():
    cursor = db.cursor()
    status = 'failure'

    email = request.args.get('email', '')
    first_name = request.args.get('first_name', '')
    last_name = request.args.get('last_name', '')
    username = request.args.get('username', '')
    passwd = request.args.get('password', '')
    sponsor = request.args.get('sponsor', '')
    query = f'SELECT UserID FROM UserInfo WHERE Username="{sponsor[3:-3]}"'
    cursor.execute(query)
    results = cursor.fetchall()
    sponsor_id=results[0][0]
    query = f'INSERT INTO DriverApplications (EMAIL, FIRST_NAME, LAST_NAME, USERNAME, PASSWD, SPONSOR_ID) VALUES("{email}","{first_name}","{last_name}","{username}","{passwd}","{sponsor_id}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

        

if __name__ == '__main__':
    app.run(debug=True)