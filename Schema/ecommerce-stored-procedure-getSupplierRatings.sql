DELIMITER $$
CREATE PROCEDURE `getSupplierRatings`()
BEGIN
	SELECT s.supp_id, 
	s.supp_name, 
    s.supp_city, 
    s.supp_phone, 
    r.rat_ratstars,
    CASE 
		WHEN r.rat_ratstars > 4 
			THEN 'Genuine Supplier'
		WHEN r.rat_ratstars > 2 
			THEN 'Average Supplier'
		ELSE 'Supplier should not be considered'
        END as "verdict"
	FROM supplier s
	LEFT OUTER JOIN rating r
		ON s.supp_id = r.supp_id;
END$$
DELIMITER ;
