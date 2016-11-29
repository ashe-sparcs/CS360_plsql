--- create a trigger 'CheckTypePC'
--- You must use / after the creation
CREATE OR REPLACE TRIGGER CheckNumProduct
BEFORE INSERT ON product
  FOR EACH ROW
  DECLARE
    product_num NUMBER;
  BEGIN
    SELECT count(model) INTO product_num FROM product WHERE maker=:NEW.maker;
    IF product_num > 9 THEN
      raise_application_error (-20000, 'Every maker can have at most 10 products.');
    END IF;
  END;
/
--- COMMIT DML COMMANDS
COMMIT;