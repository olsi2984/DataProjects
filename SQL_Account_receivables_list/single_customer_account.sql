-- AL

CREATE OR REPLACE VIEW all_customers AS
	SELECT * FROM customers_al
	UNION 
	SELECT *FROM customers_ks
	ORDER BY Cust_Name;

CREATE OR REPLACE VIEW all_dates AS
	SELECT Cust_ID, Date
	FROM init_balances
	UNION
	SELECT Cust_ID, Date
	FROM invoices
	UNION
	SELECT Cust_ID, Date
	FROM payments
	ORDER BY Date;

SELECT all_customers.Cust_ID, Cust_Name, all_dates.Date, Amount_EUR, inv_amt, payment_amt
	FROM all_dates
	JOIN all_customers ON all_customers.Cust_ID = all_dates.Cust_ID
	JOIN init_balances ON all_dates.Cust_ID = init_balances.Cust_ID
	JOIN invoices ON all_dates.Cust_ID = invoices.Cust_ID
	JOIN payments ON all_dates.Cust_ID = payments.Cust_ID
	WHERE Cust_Name =  "ABEDIN AGOLLI";

SELECT * FROM all_dates 
LEFT JOIN all_customers ON all_customers.Cust_ID = all_dates.Cust_ID
LEFT JOIN init_balances ON all_dates.Cust_ID = init_balances.Cust_ID
LEFT JOIN invoices ON all_dates.Cust_ID = invoices.Cust_ID
WHERE Cust_Name = 'ZAMIR ZENELI';