const express = require('express');
const app = express();
const mysql = require('mysql');
const port = 5000;

app.get('/', (req, res) => {
    const config = {
        user: '',
        password: '',
        server: '',
        database: ''
    };

    mysql.createConnection(config);
})

let server = app.listen(port, () => {
    console.log('Server is listening on port 5000');
});