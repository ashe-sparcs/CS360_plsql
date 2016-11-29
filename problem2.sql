--- create a trigger 'CheckTypePC'
--- You must use / after the creation
CREATE OR REPLACE TRIGGER CheckNumProduct
BEFORE INSERT ON product
  FOR EACH ROW
  DECLARE
    product_num NUMBER := 0;
  BEGIN
    FOR product_cursor IN (SELECT * FROM product WHERE maker=:NEW.maker)
    LOOP
      product_num := product_num + 1;
    END LOOP;
    IF product_num > 9 THEN
      raise_application_error (-20000, 'Every maker can have at most 10 products.');
    END IF;
  END;
/
--- COMMIT DML COMMANDS
COMMIT;