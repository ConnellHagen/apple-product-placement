const csv = require('fast-csv');
const mysql = require('mysql2');

let db = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'secret',
    database: 'appleproductplacement'
});

db.connect(err => {
    if (err)
        throw err;
});

csv.parseFile('placements.csv')
    .on('error', error => console.error(error))
    .on('data', row => processRow(row))
    .on('end', rowCount => {
        console.log(`Parsed ${rowCount} rows`);
    });

let processRow = (row) => {
    // guard clause to skip headers
    if (row[0] === 'tconst')
        return;

    let values = {
        is_movie: parseInt(row[2]),
        is_show: parseInt(row[3]),
        season: parseInt(row[4]),
        img_count: parseInt(row[6]),
        is_iphone: parseInt(row[7]),
        is_ipad: parseInt(row[8]),
        is_imac: parseInt(row[9]),
        is_macbook: parseInt(row[10]),
        is_airpods: parseInt(row[12]),
        is_apple_watch: parseInt(row[13]),
        est_year: parseInt(row[17])
    }

    // estimated year = year + season - 1
    if (!isNaN(values.season))
        values.est_year += values.season - 1

    db.query(`
        INSERT INTO movieshowpresence(msp_year, movie, tvshow, img_count)
        VALUES (?, ?, ?, ?)`, [values.est_year, values.is_movie, values.is_show, values.img_count], (err, rows) => {
        if (err)
            throw err;

        const id = rows.insertId;

        if (values.is_show == 0) {
            return;
        }

        db.query(`
            INSERT INTO showplacements(msp_id, iphone, ipad, imac, macbook, airpods, apple_watch)
            VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [id, values.is_iphone, values.is_ipad, values.is_imac, values.is_macbook, values.is_airpods, values.is_apple_watch], (err) => {
                if (err)
                    throw err;
            }
        );
    });
}
