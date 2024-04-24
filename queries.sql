/* DB schemas for creation*/
CREATE TABLE MovieShowPresence(
    id          INTEGER NOT NULL AUTO_INCREMENT,
    msp_year    INTEGER NOT NULL,
    movie       BIT(1) NOT NULL,
    tvshow      BIT(1) NOT NULL,
    img_count   INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE ShowPlacements(
    msp_id      INTEGER NOT NULL,
    iphone      BIT(1) NOT NULL,
    ipad        BIT(1) NOT NULL,
    imac        BIT(1) NOT NULL,
    macbook     BIT(1) NOT NULL,
    airpods     BIT(1) NOT NULL,
    apple_watch BIT(1) NOT NULL,
    PRIMARY KEY(msp_id),
    FOREIGN KEY(msp_id)
    REFERENCES MovieShowPresence(id)
);

/*  Gets total placements (in this dataset) per (estimated) year overall 
    Result:
    +----------+----------------+
    | msp_year | year_count_sum |
    +----------+----------------+
    |     2001 |              2 |
    |     2003 |              7 |
    |     2005 |              8 |
    |     2006 |              7 |
    |     2007 |             50 |
    |     2008 |             63 |
    |     2009 |              4 |
    |     2010 |              5 |
    |     2011 |             15 |
    |     2012 |             13 |
    |     2013 |              7 |
    |     2014 |             54 |
    |     2016 |              7 |
    |     2017 |              7 |
    |     2018 |             20 |
    |     2019 |             41 |
    |     2020 |            860 |
    |     2021 |           2894 |
    |     2022 |           4132 |
    |     2023 |           5169 |
    |     2024 |             42 |
    |     2025 |              2 |
    +----------+----------------+
*/
SELECT msp_year, SUM(img_count) AS year_count_sum
FROM MovieShowPresence
GROUP BY msp_year
ORDER BY msp_year;

/*  Compares placements per year by movie/show categories
    Show is 0x00, Movie is 0x01
    Result:
    +----------+--------------+----------+
    | msp_year | movie        | year_sum |
    +----------+--------------+----------+
    |     2001 | 0x00         |        1 |
    |     2005 | 0x00         |        8 |
    |     2007 | 0x00         |       47 |
    |     2008 | 0x00         |       58 |
    |     2010 | 0x00         |        5 |
    |     2011 | 0x00         |       13 |
    |     2012 | 0x00         |        7 |
    |     2013 | 0x00         |        7 |
    |     2014 | 0x00         |       43 |
    |     2016 | 0x00         |        7 |
    |     2017 | 0x00         |        7 |
    |     2018 | 0x00         |       18 |
    |     2019 | 0x00         |       40 |
    |     2020 | 0x00         |      761 |
    |     2021 | 0x00         |     2693 |
    |     2022 | 0x00         |     3680 |
    |     2023 | 0x00         |     3153 |
    |     2024 | 0x00         |       42 |
    |     2025 | 0x00         |        2 |
    |     2001 | 0x01         |        1 |
    |     2003 | 0x01         |        7 |
    |     2006 | 0x01         |        7 |
    |     2007 | 0x01         |        3 |
    |     2008 | 0x01         |        5 |
    |     2009 | 0x01         |        4 |
    |     2011 | 0x01         |        2 |
    |     2012 | 0x01         |        6 |
    |     2014 | 0x01         |       11 |
    |     2018 | 0x01         |        2 |
    |     2019 | 0x01         |        1 |
    |     2020 | 0x01         |       99 |
    |     2021 | 0x01         |      201 |
    |     2022 | 0x01         |      452 |
    |     2023 | 0x01         |     2016 |
    +----------+--------------+----------+
*/
SELECT msp_year, movie, SUM(img_count) AS year_sum
FROM MovieShowPresence
GROUP BY msp_year, movie
ORDER BY movie, msp_year;

/*  Compares product placements year-by-year, for each product 
    Result:
    +----------+----------------+--------------+--------------+-----------------+-----------------+---------------+
    | msp_year | iphone_by_year | ipad_by_year | imac_by_year | macbook_by_year | airpods_by_year | watch_by_year |
    +----------+----------------+--------------+--------------+-----------------+-----------------+---------------+
    |     2001 |              0 |            0 |            0 |               1 |               0 |             0 |
    |     2005 |              1 |            4 |            1 |               0 |               0 |             0 |
    |     2007 |             29 |            6 |            0 |               9 |               0 |             0 |
    |     2008 |             11 |            3 |            3 |               4 |               0 |             0 |
    |     2010 |              3 |            0 |            0 |               0 |               0 |             0 |
    |     2011 |              5 |            2 |            1 |               0 |               0 |             2 |
    |     2012 |              1 |            0 |            0 |               4 |               0 |             0 |
    |     2013 |              2 |            3 |            0 |               0 |               0 |             0 |
    |     2014 |              1 |            1 |            0 |               1 |               0 |             0 |
    |     2016 |              5 |            0 |            0 |               1 |               0 |             0 |
    |     2017 |              1 |            1 |            1 |               1 |               0 |             0 |
    |     2018 |              2 |            1 |            1 |               8 |               0 |             0 |
    |     2019 |             16 |            3 |            3 |               9 |               0 |             0 |
    |     2020 |            117 |           29 |           65 |             257 |               0 |            14 |
    |     2021 |            343 |          100 |          149 |             549 |               5 |            46 |
    |     2022 |            407 |          107 |          211 |             572 |               6 |            93 |
    |     2023 |            253 |           66 |           71 |             235 |              13 |            60 |
    |     2024 |              6 |            0 |            1 |               0 |               0 |             0 |
    |     2025 |              0 |            0 |            1 |               0 |               0 |             0 |
    +----------+----------------+--------------+--------------+-----------------+-----------------+---------------+
*/
SELECT msp.msp_year, 
       SUM(sp.iphone)      AS iphone_by_year,
       SUM(sp.ipad)        AS ipad_by_year,
       SUM(sp.imac)        AS imac_by_year,
       SUM(sp.macbook)     AS macbook_by_year,
       SUM(sp.airpods)     AS airpods_by_year,
       SUM(sp.apple_watch) AS watch_by_year
FROM ShowPlacements sp, MovieShowPresence msp
WHERE sp.msp_id = msp.id
GROUP BY msp.msp_year
ORDER BY msp_year;

/*  Calculates sum of number of each product for normalization by product type relations
    Result:
    +--------------+------------+------------+---------------+---------------+-------------+
    | iphone_total | ipad_total | imac_total | macbook_total | airpods_total | watch_total |
    +--------------+------------+------------+---------------+---------------+-------------+
    |         1203 |        326 |        508 |          1651 |            24 |         215 |
    +--------------+------------+------------+---------------+---------------+-------------+
*/
SELECT SUM(sp.iphone)      AS iphone_total,
       SUM(sp.ipad)        AS ipad_total,
       SUM(sp.imac)        AS imac_total,
       SUM(sp.macbook)     AS macbook_total,
       SUM(sp.airpods)     AS airpods_total,
       SUM(sp.apple_watch) AS watch_total
FROM ShowPlacements sp, MovieShowPresence msp
WHERE sp.msp_id = msp.id;

/*  Normalized (by product type) distribution of product by year (good for comparing products to each other)
    Result:
    +----------+----------------+--------------+--------------+-----------------+-----------------+---------------+
    | msp_year | iphone_by_year | ipad_by_year | imac_by_year | macbook_by_year | airpods_by_year | watch_by_year |
    +----------+----------------+--------------+--------------+-----------------+-----------------+---------------+
    |     2001 |         0.0000 |       0.0000 |       0.0000 |          0.0006 |          0.0000 |        0.0000 |
    |     2005 |         0.0008 |       0.0123 |       0.0020 |          0.0000 |          0.0000 |        0.0000 |
    |     2007 |         0.0241 |       0.0184 |       0.0000 |          0.0055 |          0.0000 |        0.0000 |
    |     2008 |         0.0091 |       0.0092 |       0.0059 |          0.0024 |          0.0000 |        0.0000 |
    |     2010 |         0.0025 |       0.0000 |       0.0000 |          0.0000 |          0.0000 |        0.0000 |
    |     2011 |         0.0042 |       0.0061 |       0.0020 |          0.0000 |          0.0000 |        0.0093 |
    |     2012 |         0.0008 |       0.0000 |       0.0000 |          0.0024 |          0.0000 |        0.0000 |
    |     2013 |         0.0017 |       0.0092 |       0.0000 |          0.0000 |          0.0000 |        0.0000 |
    |     2014 |         0.0008 |       0.0031 |       0.0000 |          0.0006 |          0.0000 |        0.0000 |
    |     2016 |         0.0042 |       0.0000 |       0.0000 |          0.0006 |          0.0000 |        0.0000 |
    |     2017 |         0.0008 |       0.0031 |       0.0020 |          0.0006 |          0.0000 |        0.0000 |
    |     2018 |         0.0017 |       0.0031 |       0.0020 |          0.0048 |          0.0000 |        0.0000 |
    |     2019 |         0.0133 |       0.0092 |       0.0059 |          0.0055 |          0.0000 |        0.0000 |
    |     2020 |         0.0973 |       0.0890 |       0.1280 |          0.1557 |          0.0000 |        0.0651 |
    |     2021 |         0.2851 |       0.3067 |       0.2933 |          0.3325 |          0.2083 |        0.2140 |
    |     2022 |         0.3383 |       0.3282 |       0.4154 |          0.3465 |          0.2500 |        0.4326 |
    |     2023 |         0.2103 |       0.2025 |       0.1398 |          0.1423 |          0.5417 |        0.2791 |
    |     2024 |         0.0050 |       0.0000 |       0.0020 |          0.0000 |          0.0000 |        0.0000 |
    |     2025 |         0.0000 |       0.0000 |       0.0020 |          0.0000 |          0.0000 |        0.0000 |
    +----------+----------------+--------------+--------------+-----------------+-----------------+---------------+
*/
SELECT msp.msp_year, 
       SUM(sp.iphone) / 1203     AS iphone_by_year,
       SUM(sp.ipad) / 326        AS ipad_by_year,
       SUM(sp.imac) / 508        AS imac_by_year,
       SUM(sp.macbook) / 1651    AS macbook_by_year,
       SUM(sp.airpods) / 24      AS airpods_by_year,
       SUM(sp.apple_watch) / 215 AS watch_by_year
FROM ShowPlacements sp, MovieShowPresence msp
WHERE sp.msp_id = msp.id
GROUP BY msp.msp_year
ORDER BY msp_year;

/*  Distribution VERY roughly normalized within each year (good for comparing each year to each other)
    Result:
    +----------+-----------------+---------------+---------------+------------------+------------------+----------------+
    | msp_year | iphone_weighted | ipad_weighted | imac_weighted | macbook_weighted | airpods_weighted | watch_weighted |
    +----------+-----------------+---------------+---------------+------------------+------------------+----------------+
    |     2001 |          0.0000 |        0.0000 |        0.0000 |           1.0000 |           0.0000 |         0.0000 |
    |     2005 |          0.1250 |        0.5000 |        0.1250 |           0.0000 |           0.0000 |         0.0000 |
    |     2007 |          0.6170 |        0.1277 |        0.0000 |           0.1915 |           0.0000 |         0.0000 |
    |     2008 |          0.1897 |        0.0517 |        0.0517 |           0.0690 |           0.0000 |         0.0000 |
    |     2010 |          0.6000 |        0.0000 |        0.0000 |           0.0000 |           0.0000 |         0.0000 |
    |     2011 |          0.3846 |        0.1538 |        0.0769 |           0.0000 |           0.0000 |         0.1538 |
    |     2012 |          0.1429 |        0.0000 |        0.0000 |           0.5714 |           0.0000 |         0.0000 |
    |     2013 |          0.2857 |        0.4286 |        0.0000 |           0.0000 |           0.0000 |         0.0000 |
    |     2014 |          0.0233 |        0.0233 |        0.0000 |           0.0233 |           0.0000 |         0.0000 |
    |     2016 |          0.7143 |        0.0000 |        0.0000 |           0.1429 |           0.0000 |         0.0000 |
    |     2017 |          0.1429 |        0.1429 |        0.1429 |           0.1429 |           0.0000 |         0.0000 |
    |     2018 |          0.1111 |        0.0556 |        0.0556 |           0.4444 |           0.0000 |         0.0000 |
    |     2019 |          0.4000 |        0.0750 |        0.0750 |           0.2250 |           0.0000 |         0.0000 |
    |     2020 |          0.1537 |        0.0381 |        0.0854 |           0.3377 |           0.0000 |         0.0184 |
    |     2021 |          0.1274 |        0.0371 |        0.0553 |           0.2039 |           0.0019 |         0.0171 |
    |     2022 |          0.1106 |        0.0291 |        0.0573 |           0.1554 |           0.0016 |         0.0253 |
    |     2023 |          0.0802 |        0.0209 |        0.0225 |           0.0745 |           0.0041 |         0.0190 |
    |     2024 |          0.1429 |        0.0000 |        0.0238 |           0.0000 |           0.0000 |         0.0000 |
    |     2025 |          0.0000 |        0.0000 |        0.5000 |           0.0000 |           0.0000 |         0.0000 |
    +----------+-----------------+---------------+---------------+------------------+------------------+----------------+
*/
SELECT msp.msp_year, 
       SUM(sp.iphone) / SUM(msp.img_count)      AS iphone_weighted,
       SUM(sp.ipad) / SUM(msp.img_count)        AS ipad_weighted,
       SUM(sp.imac) / SUM(msp.img_count)        AS imac_weighted,
       SUM(sp.macbook) / SUM(msp.img_count)     AS macbook_weighted,
       SUM(sp.airpods) / SUM(msp.img_count)     AS airpods_weighted,
       SUM(sp.apple_watch) / SUM(msp.img_count) AS watch_weighted
FROM ShowPlacements sp, MovieShowPresence msp
WHERE sp.msp_id = msp.id
GROUP BY msp.msp_year
ORDER BY msp.msp_year;
