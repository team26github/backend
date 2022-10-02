from flask import Flask, jsonify, request
from flask_cors import CORS

DEBUG = True

app = Flask(__name__)
app.config.from_object(__name__)

CORS(app, resources={r'/*': {'origins': '*'}})

login_info = {'username': '', 'password': ''}

@app.route('/login', methods=['GET', 'POST'])
def login():
    login_info['username'] = request.args['username']
    login_info['password'] = request.args['password']

    return jsonify({
        'status': 'success',
        'login': login_info
    })


if __name__ == '__main__':
    app.run()