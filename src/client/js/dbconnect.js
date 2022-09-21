const test_connection = document.querySelector('#test-connection');

test_connection.addEventListener("click", () => {
    const mysql = require('mysql');
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'user',
        password: 'password'
    });

    connection.connect((error) => {
        if (error) throw error;
        window.alert('Connection established successfully');
    });

    connection.end((error) => {
        if (error) throw error;
    });
});