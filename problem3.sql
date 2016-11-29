--- create a procedure inserts_pc
--- You must use / after the creation
CREATE OR REPLACE PROCEDURE insert_pc(
	v_maker IN VARCHAR2,
	v_model IN NUMBER,
	v_speed IN NUMBER,
	v_ram IN NUMBER,
	v_hd IN NUMBER,
	v_price IN NUMBER
)
IS
BEGIN
  INSERT INTO product(maker, model, type)
    VALUES (v_maker, v_model, 'pc');
  INSERT INTO pc(model, speed, ram, hd, price)
    VALUES (v_model, v_speed, v_ram, v_hd, v_price);
EXCEPTION
  WHEN dup_val_on_index THEN
    raise_application_error(-20001, 'Duplicated index');
END;
/
--- COMMIT DML COMMANDS
COMMIT;