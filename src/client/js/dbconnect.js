/*
import mysql from 'mysql2'

const db = mysql.createConnection({
    host: 'team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com',
    user: 'admin',
    password: 'p83YoUoffEo0xChEq9kG',
    database: 'Team26Database'
});

export default db;
*/

/*
import express from 'express'
import mysql from 'mysql'
export const dbapp = express();
export const port = 5000;

export function connect() {
    dbapp.get('/', (req, res) => {
        const config = {
            host: 'team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com',
            user: 'admin',
            password: 'p83YoUoffEo0xChEq9kG',
            database: 'Team26Database'
        };

        let connection = mysql.createConnection(config);

        connection.connect((err) => {
            if (err) throw err;
            connection.query('select * from TotalFeesLog', (err, result, fields) => {
                if (err) throw err;
                res.send(result);
            });
        });
    })
}

export let server = dbapp.listen(port, () => {
    console.log('Server is listening on port 5000');
});
 */

express = require('express');
mysql = require('mysql');
const dbapp = express();
const port = 5000;

dbapp.get('/', (req, res) => {
    const config = {
        host: 'team26-db.cpin0o6jvads.us-east-2.rds.amazonaws.com',
        user: 'admin',
        password: 'p83YoUoffEo0xChEq9kG',
        database: 'Team26Database'
    };

    let connection = mysql.createConnection(config);

    connection.connect((err) => {
        if (err) throw err;
        connection.query('select * from TotalFeesLog', (err, result, fields) => {
            if (err) throw err;
            res.send(result);
        });
    });
})

let server = dbapp.listen(port, () => {
    console.log('Server is listening on port 5000');
});