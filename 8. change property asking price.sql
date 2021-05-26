create or replace procedure change_price
(v_asking_price number, v_property_id number)


as

input_error  Exception; 
v_count number;


Cursor pid_exist
	IS
	Select count(*) from property where property_id = v_property_id;


begin

v_count:= 0;
open pid_exist;
fetch pid_exist into v_count;
close pid_exist;

if v_count = 0 then
raise input_error;
end if;

UPDATE property
SET asking_price = v_asking_price
WHERE property_id = v_property_id AND status = 'Available';

commit;

Exception

	when input_error then
	dbms_output.put_line('ID fail');	

end;
/
