create or replace procedure property_state (v_state char)

as	

cursor_returned_no_rows exception;

CURSOR c_PROPERTY IS
select *
from property
where upper(state) = upper(v_state);



CURSOR c_PROPERTY2 IS
select *
from property
where upper(state) = upper(v_state);

v_rec c_property2%rowtype;

begin

 
open c_property2;
fetch c_property2 into v_rec;
if c_property2%notfound

        then

          raise cursor_returned_no_rows;

      end if;
      

FOR v_property_data IN c_PROPERTY LOOP

    dbms_output.put_line(TO_CHAR(v_property_data.property_id) || ' '|| v_property_data.street || ' ' || TO_CHAR(v_property_data.street) || ' ' ||
                        v_property_data.city || ' ' || v_property_data.state || ' ' || TO_CHAR(v_property_data.asking_price) || ' ' || TO_CHAR(v_property_data.tot_size) || ' ' ||
                       v_property_data.status || ' ' || TO_CHAR(v_property_data.date_of_const) || ' ' || v_property_data.property_type || ' ' || TO_CHAR(v_property_data.firm_id) || ' ' ||
                        TO_CHAR(v_property_data.agent_id));
                        
 
end loop;


exception

  when cursor_returned_no_rows

  then

    dbms_output.put_line ('State not identified in record');
 

end;
/
    