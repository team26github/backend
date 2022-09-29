express = require('express');
mysql = require('mysql');
const dbapp = express();
const port = 8080;

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
    console.log('Server is listening on port 8080');
});