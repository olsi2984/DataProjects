-- AL

SELECT Cust_Name, IFNULL(Faturat,0) AS Faturat, 
	IFNULL(Pagesat,0) AS Pagesat, 
	IFNULL(Amount_EUR,0) AS Balanca, 
	IFNULL(Faturat,0) + IFNULL(Amount_EUR,0) - IFNULL(Pagesat,0) AS Detyrimi
FROM customers_al ca
LEFT JOIN (SELECT Cust_ID, SUM(inv_amt) AS Faturat FROM invoices GROUP BY Cust_ID) AS i 
	ON ca.Cust_ID = i.Cust_ID
LEFT JOIN (SELECT Cust_ID, SUM(payment_amt) AS Pagesat FROM payments GROUP BY Cust_ID) AS p 
	ON ca.Cust_ID = p.Cust_ID
LEFT JOIN init_balances ib 
	ON ca.Cust_ID = ib.Cust_ID
GROUP BY Cust_Name
HAVING Detyrimi != 0
;

-- KS

SELECT Cust_Name, IFNULL(Faturat,0) AS Faturat, 
	IFNULL(Pagesat,0) AS Pagesat, 
	IFNULL(Amount_EUR,0) AS Balanca, 
	IFNULL(Faturat,0) + IFNULL(Amount_EUR,0) - IFNULL(Pagesat,0) AS Detyrimi
FROM customers_ks ca
LEFT JOIN (SELECT Cust_ID, SUM(inv_amt) AS Faturat FROM invoices GROUP BY Cust_ID) AS i 
	ON ca.Cust_ID = i.Cust_ID
LEFT JOIN (SELECT Cust_ID, SUM(payment_amt) AS Pagesat FROM payments GROUP BY Cust_ID) AS p 
	ON ca.Cust_ID = p.Cust_ID
LEFT JOIN init_balances ib 
	ON ca.Cust_ID = ib.Cust_ID
GROUP BY Cust_Name
HAVING Detyrimi != 0
;