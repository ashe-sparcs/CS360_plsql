--- create a function 'FindCenterPrice'
--- You must use / after the creation
CREATE OR REPLACE FUNCTION findCenterPrice
RETURN NUMBER
IS
  v_sum_min NUMBER := -1;
  v_sum_temp NUMBER;
  v_center_price NUMBER := 0;
BEGIN
  FOR pc_cursor IN (SELECT price FROM pc)
  LOOP
    v_sum_temp := 0;
    FOR pc_cursor2 IN (SELECT price FROM pc)
    LOOP
      v_sum_temp := v_sum_temp + abs(pc_cursor.price - pc_cursor2.price);
    END LOOP;
    if v_sum_temp < v_sum_min OR v_sum_min = -1 THEN
      v_sum_min := v_sum_temp;
      v_center_price := pc_cursor.price;
    END IF;
  END LOOP;
  RETURN v_center_price;
END;
/
--- COMMIT DML COMMANDS
COMMIT;