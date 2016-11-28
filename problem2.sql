--- create a trigger 'CheckTypePC'
--- You must use / after the creation
CREATE OR REPLACE TRIGGER CheckNumProduct
BEFORE INSERT ON product
  DECLARE
    max_product_num NUMBER;
  BEGIN
    max_product_num := (SELECT max(product_num) FROM (SELECT maker, count(maker) AS product_num FROM product GROUP BY maker));
    IF 9 < max_product_num THEN
      raise_application_error (-20000, 'Every maker can have at most 10 products.');
    END IF;
  END;
/
--- COMMIT DML COMMANDS
COMMIT;