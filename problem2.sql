--- create a trigger 'CheckTypePC'
--- You must use / after the creation
CREATE OR REPLACE TRIGGER CheckNumProduct
BEFORE INSERT ON product
  DECLARE
    max_product_num NUMBER;
  BEGIN
    FOR product_cursor IN (SELECT maker, count(maker) AS product_num FROM product GROUP BY maker)
    LOOP
      IF product_cursor.product_num > max_product_num THEN
        max_product_num := product_cursor.product_num;
      END IF;
    END LOOP;
    IF max_product_num > 9 THEN
      raise_application_error (-20000, 'Every maker can have at most 10 products.');
    END IF;
  END;
/
--- COMMIT DML COMMANDS
COMMIT;