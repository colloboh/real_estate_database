create or replace procedure insert_room
(v_room_id number, v_room_type varchar, v_room_size int, v_flooring_type varchar, v_property_id number)

is
 	
    	

    v_count int;
    
    begin
    
    select count(*)
    into v_count
    from property
    where property.property_id = v_property_id;
    
    if v_count = 0  
    then 
    dbms_output.put_line('Property ID not found'); 
    
    elsif upper(v_room_type) != 'LIVING ROOM' and  upper(v_room_type) !='KITCHEN' and  upper(v_room_type) !='BEDROOM'
     then 
    dbms_output.put_line('room type not found');
    else
                                                                                                                                                     
                begin
                insert into rooms values 
		        (v_room_id, v_room_type, v_room_size, v_flooring_type, v_property_id);
                commit;
                end;
      
   end if;
  
                
    
    
		
end;

 