from urllib.parse import urlencode
from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from datetime import datetime, timedelta
import pymysql
import requests
import json

app = Flask(__name__)
app.config.from_object(__name__)
db = pymysql.connect(host='team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com', user='admin', password='p83YoUoffEo0xChEq9kG', database='Team26Database')

CORS(app, resources={r"/*": {"origins": "*"}}, supports_credentials=True)

def get_new_token():
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic R3JhbnRHb24tVGVhbTI2LVNCWC1hZDI2MDVjYjQtNWNlMjdhNjY6U0JYLWQyNjA1Y2I0NWNiMi1iMWYzLTRjMjItOGU4NS0zMjA5'
    }

    body = {
        'grant_type': 'client_credentials',
        'scope': 'https://api.ebay.com/oauth/api_scope'
    }

    res = requests.post('https://api.sandbox.ebay.com/identity/v1/oauth2/token', headers=headers, data=body)

    data = json.loads(res.content)
    global EBAY_TOKEN
    EBAY_TOKEN = data['access_token']
    global EXPIRES
    EXPIRES = datetime.now() + timedelta(seconds=7200)

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
def get_drivers():
    user_id = request.args.get('user_id', '')
    cursor = db.cursor()
    
    query = f'SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) FROM DriverApplications WHERE SPONSOR_ID = {user_id} AND APP_STATUS = "Pending"'

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

@app.route('/purchase-info', methods=['GET'])
def get_purchase_info():
    user_id = request.args.get('user_id', '')
    results = {}
    cursor = db.cursor()

    query = f'SELECT * FROM Purchases WHERE USER_ID = {"user_id"}'
    cursor.execute(query)
    results['purchases'] = cursor.fetchall()

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


@app.route('/info', methods=['GET'])
def get_info():
    username = request.args.get('username', '')
    results = {}
    cursor = db.cursor()

    query = f'SELECT * FROM UserInfo WHERE UserType = "Driver"'
    cursor.execute(query)
    results['drivers'] = cursor.fetchall()

    query = f'SELECT * FROM UserInfo WHERE UserType = "Sponsor"'
    cursor.execute(query)
    results['sponsors'] = cursor.fetchall()

    query = f'SELECT * FROM UserInfo WHERE UserType = "Admin" and Username != "{username}"'
    cursor.execute(query)
    results['admins'] = cursor.fetchall()

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


@app.route('/get-catalog-items', methods=['GET'])
def get_catalog_items():
    if EXPIRES < datetime.now():
        get_new_token()
    
    status = 'failure'
    sandbox_url = 'https://api.sandbox.ebay.com/buy/browse/v1/item_summary/search?'
    keywords = request.args.get('keywords', '')
    headers = {
        'Authorization': f'Bearer {EBAY_TOKEN}',
    }
    params = {
        'limit': 100,
        'offset': 0,
        'q': f'({keywords})',
    }

    results = requests.get(f'{sandbox_url}', headers=headers, params=params).json()

    cursor = db.cursor()
    query = 'SELECT ITEMS FROM Purchases'
    cursor.execute(query)
    purchased = cursor.fetchall()

    try:
        results['itemSummaries']
        status = 'success'
    except:
        status = 'failure'

    return jsonify({
        'status': status,
        'results': results['itemSummaries'],
        'purchased': purchased
    })

@app.route('/update-catalog-filters', methods=['POST'])
@cross_origin()
def update_catalog_filters():
    sponsor_id = request.args.get('user_id', '')
    filters = request.args.get('catalog_filters', '')
    
    cursor = db.cursor()
    query = f'UPDATE UserInfo SET CatalogItemKeywords = "{filters}" WHERE SponsorID = {sponsor_id};'
    cursor.execute(query)
    db.commit()

    return jsonify({
        'status': 'success'
    })

@app.route('/conversion', methods=['POST'])
@cross_origin()
def edit_point_conversion():
    point_conversion = request.args.get('point_conversion', '')
    sponsor_id = request.args.get('sponsorID', '')
    status = 'failure'
    cursor = db.cursor()

    if point_conversion == '' or sponsor_id == '':
        return jsonify({
            'status': status
        })
    
    query = f'UPDATE UserInfo SET DollarPointValue = {float(point_conversion)} WHERE SponsorID = {sponsor_id}'
    cursor.execute(query)
    db.commit()
    status = 'success'

    return jsonify({
        'status': status
    })
        
@app.route('/new-driver', methods=['POST'])
@cross_origin()
def new_driver():
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
    query = f'INSERT INTO UserInfo (passwd, UserType, Email, Username, PointsLimit, ExpirationPeriod, SponsorID, DollarPointValue, Fullname) VALUES("{passwd}","Driver", "{email}","{username}",100000, 12, "{sponsor_id}", 3.25, "{first_name} {last_name}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/new-sponsor', methods=['POST'])
@cross_origin()
def new_sponser():
    cursor = db.cursor()
    status = 'failure'

    email = request.args.get('email', '')
    first_name = request.args.get('first_name', '')
    last_name = request.args.get('last_name', '')
    username = request.args.get('username', '')
    passwd = request.args.get('password', '')

    query = f'INSERT INTO UserInfo (passwd, UserType, Email, Username, PointsLimit, ExpirationPeriod, DollarPointValue, Fullname) VALUES("{passwd}","Sponsor", "{email}","{username}",100000, 12, 3.25, "{first_name} {last_name}")'
    cursor.execute(query)

    query = f'SELECT UserID FROM UserInfo WHERE email="{email}"'
    cursor.execute(query)
    results = cursor.fetchall()
    sponsor_id=results[0][0]
    
    query = f'UPDATE UserInfo SET SponsorID = "{sponsor_id}" WHERE email="{email}"'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/new-admin', methods=['POST'])
@cross_origin()
def new_admin():
    cursor = db.cursor()
    status = 'failure'

    email = request.args.get('email', '')
    first_name = request.args.get('first_name', '')
    last_name = request.args.get('last_name', '')
    username = request.args.get('username', '')
    passwd = request.args.get('password', '')
    
    query = f'INSERT INTO UserInfo (passwd, UserType, Email, Username, PointsLimit, ExpirationPeriod, SponsorID, DollarPointValue, Fullname) VALUES("{passwd}","Admin", "{email}","{username}",100000, 12, 0, 3.25, "{first_name} {last_name}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/update-info', methods=['POST'])
@cross_origin()
def update_info():
    data = json.loads(request.args.get('update_data', ''))
    user = request.args.get('user_id', '')
    status = 'failure'
    cursor = db.cursor()

    for key in data:
        if key == 'PointsLimit' or key == 'SponsorID':
            query = f'UPDATE UserInfo SET {key} = {int(data[key])} WHERE UserID = {user}'
        elif key == 'DollarPointValue':
            query = f'UPDATE UserInfo SET {key} = {float(data[key])} WHERE UserID = {user}'
        else:
            query = f'UPDATE UserInfo SET {key} = "{data[key]}" WHERE UserID = {user}'
        cursor.execute(query)
        db.commit()

    status = 'success'

    return jsonify({
        'status': status
    })

@app.route('/add_points', methods=['POST'])
@cross_origin()
def submit():
    cursor = db.cursor()
    status = 'failure'

    num_points = request.args.get('num_points', '')
    reason = request.args.get('reason', '')
    driver = request.args.get('driver', '')
    sponsor_id = request.args.get('sponsor', '')
    print(driver)
    query = f'SELECT DRIVER_ID FROM DriverApplications WHERE FIRST_NAME="{str(driver).split()[0]}" AND LAST_NAME="{str(driver).split()[1]}"'
    cursor.execute(query)
    results = cursor.fetchall()
    driver_id=results[0][0]
    query = f'INSERT INTO PointsChange (DriverID, PointChange, DateTimeStamp, ChangeReason, PointChangerID) VALUES("{driver_id}","{num_points}","{datetime.now()}","{reason}","{sponsor_id}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/pending_applications', methods=['POST'])
@cross_origin()
def submit_app_decision():
    cursor = db.cursor()
    status = 'failure'

    driver = request.args.get('driver', '')
    reason = request.args.get('reason', '')
    sponsor_id = request.args.get('sponsor', '')
    decision = request.args.get('decision', '')

    query = f'SELECT DRIVER_ID FROM DriverApplications WHERE FIRST_NAME="{str(driver).split()[0]}" AND LAST_NAME="{str(driver).split()[1]}"'
    cursor.execute(query)
    results = cursor.fetchall()
    driver_id=results[0][0]
    query = f'INSERT INTO DriverAppLog (DriverAppID, Date, Changer, StatusChange, Reason) VALUES("{driver_id}","{datetime.now()}","{sponsor_id}", "{decision}", "{reason}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/remove_points', methods=['POST'])
@cross_origin()
def submit_deduction():
    cursor = db.cursor()
    status = 'failure'

    num_points = request.args.get('num_points', '')
    num_points = -abs(int(num_points))
    reason = request.args.get('reason', '')
    driver = request.args.get('driver', '')
    sponsor_id = request.args.get('sponsor', '')

    query = f'SELECT DRIVER_ID FROM DriverApplications WHERE FIRST_NAME="{str(driver).split()[0]}" AND LAST_NAME="{str(driver).split()[1]}"'
    cursor.execute(query)
    results = cursor.fetchall()
    driver_id=results[0][0]
    query = f'INSERT INTO PointsChange (DriverID, PointChange, DateTimeStamp, ChangeReason, PointChangerID) VALUES("{driver_id}","{num_points}","{datetime.now()}","{reason}","{sponsor_id}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/submit-purchase', methods=['POST'])
@cross_origin()
def submit_purchase():
    cursor = db.cursor()
    status = 'failure'

    first_name = request.args.get('first_name', '')
    last_name = request.args.get('last_name', '')
    address = request.args.get('address', '')
    address_city = request.args.get('address_city', '')
    address_state = request.args.get('address_state', '')
    address_zip_code = request.args.get('address_zip_code', '')
    email = request.args.get('email', '')
    items_array = json.loads(request.args.get('items', ''))
    items_total = request.args.get('items_total', '')
    points_total = request.args.get('points_total', '')
    user_id = request.args.get('user_id', '')
    
    items = {}
    index = 0
    for item in items_array:
        items[index] = item
        index += 1
    
    query = f'INSERT INTO Purchases (FIRST_NAME, LAST_NAME, ADDRESS, CITY, STATE, ZIP_CODE, EMAIL, ITEMS_TOTAL, POINTS_TOTAL, ITEMS, USER_ID) VALUES("{first_name}", "{last_name}", "{address}", "{address_city}", "{address_state}", "{address_zip_code}", "{email}", {items_total}, {points_total}, "{items}", "{user_id}")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

@app.route('/add-items-to-cart', methods=['POST'])
@cross_origin()
def add_items_to_cart():
    sponsor_id = request.args.get('user_id', '')
    items = request.args.get('items', '')
    
    cursor = db.cursor()
    query = f'UPDATE Purchases SET ITEMS = "{items}" WHERE USER_ID = {user_id};'
    cursor.execute(query)
    db.commit()

    return jsonify({
        'status': 'success'
    })

@app.route('/remove_points_purchase', methods=['POST'])
@cross_origin()
def points_purchase():
    cursor = db.cursor()
    status = 'failure'

    points = request.args.get('points_total', '')
    num_points = -abs(int(num_points))
    reason = request.args.get('reason', '')
    email = request.args.get('email', '')

    query = f'SELECT UserID FROM UserInfo WHERE Email = "{email}"'
    cursor.execute(query)
    results = cursor.fetchall()
    user_id=results[0][0]

    query = f'SELECT Points FROM UserInfo WHERE UserID = "{user_id}"'
    cursor.execute(query)
    results = cursor.fetchall()
    points=results[0][0]

    new_points = points - num_points

    query = f'UPDATE UserInfo SET Points = "{new_points}" WHERE UserID = "{user_id}"'

    query = f'INSERT INTO PointsChange (DriverID, PointChange, DateTimeStamp, ChangeReason, PointChangerID) VALUES("{user_id}","{num_points}","{datetime.now()}","{reason}","0")'
    cursor.execute(query)

    db.commit()
    status = 'success'
        
    return jsonify({'status': status})

if __name__ == '__main__':
    get_new_token()
    app.run(debug=True)