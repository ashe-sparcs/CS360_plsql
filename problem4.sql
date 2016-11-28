--- create a function 'FindCenterPrice'
--- You must use / after the creation
CREATE OR REPLACE FUNCTION findCenterPrice
RETURN NUMBER
IS
  v_sum_min NUMBER;
  v_sum_temp NUMBER;
  v_center_price NUMBER := 0;
BEGIN
  v_center_price := 0;
  v_sum_min := (SELECT sum(price) FROM pc);
  FOR pc_cursor IN (SELECT price FROM pc)
  LOOP
    v_sum_temp := (SELECT sum(abs(price-pc_cursor.price)) FROM pc);
    if v_sum_temp < v_sum_min THEN
      v_sum_min := v_sum_temp;
      v_center_price := pc_cursor.price;
    END IF;
  END LOOP;
  RETURN v_center_price;
END;

/


--- COMMIT DML COMMANDS
COMMIT;