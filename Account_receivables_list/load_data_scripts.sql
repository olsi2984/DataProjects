-- Load data into table customers_al

LOAD DATA INFILE 'D:/Dokumenta/Kontrolle/Detyrimet/AP_SV/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Load data into table customers_ks

LOAD DATA INFILE 'D:/Dokumenta/Kontrolle/Detyrimet/AP_SV/customers_ks.csv'
INTO TABLE customers_ks
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Load data into table init_balances

LOAD DATA INFILE 'D:/Dokumenta/Kontrolle/Detyrimet/AP_SV/init_balances.csv'
INTO TABLE init_balances
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Load data into table invoices

LOAD DATA INFILE 'D:/Dokumenta/Kontrolle/Detyrimet/AP_SV/invoices.csv'
INTO TABLE invoices
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

-- Load data into table payments

LOAD DATA INFILE 'D:/Dokumenta/Kontrolle/Detyrimet/AP_SV/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;