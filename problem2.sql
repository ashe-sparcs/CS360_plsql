--- create a trigger 'CheckTypePC'
--- You must use / after the creation
CREATE OR REPLACE TRIGGER CheckNumProduct
BEFORE INSERT ON product
BEGIN
  IF 9 < (SELECT max(product_num) FROM (SELECT maker, count(maker) AS product_num FROM product GROUP BY maker)) THEN
    raise_application_error (-20000, 'Every maker can have at most 10 products.');
  END IF;
END
/

--- COMMIT DML COMMANDS
COMMIT;