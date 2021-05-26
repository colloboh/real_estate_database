create or replace procedure valid_agent
(v_property_id number, v_street varchar, v_zip int, v_city varchar, v_state char, v_asking_price numeric, v_tot_size int, v_status varchar, v_date_of_const DATE, 
 v_property_type varchar, v_firm_id number, v_agent_id number)

is
 	
  	v_ErrorCode number;		--USED FOR ERROR CHECKING
	v_ErrorMsg  Varchar2(200);
	v_CurrentUser Varchar2(100);
	v_record_count  number;
    v_count int;

	begin
    
	select count(*) 
	into v_count
	from agent
	where v_agent_id = agent_id;


	if v_count = 0 then
		
		dbms_output.put_line('Agent ID not valid');
        
	else	

		begin
	--INSERT HERE
	INSERT INTO property values
	(v_property_id, v_street, v_zip, v_city, v_state, v_asking_price, v_tot_size, v_status, v_date_of_const, 
 v_property_type, v_firm_id, v_agent_id);
    
    UPDATE property
    SET status = 'Available' WHERE status = v_status;
    
	commit;
        end;


end if;
	exception



		WHEN OTHERS THEN
			v_ErrorCode := SQLCODE;
			v_ErrorMsg := substr(SQLERRM,1,200);
			v_CurrentUser := USER;
 	
			DBMS_OUTPUT.PUT_LINE( TO_CHAR(SYSDATE)  || v_CurrentUser 
  			|| TO_CHAR(v_ErrorCode)  ||  v_ErrorMsg);
		


END valid_agent; 
/
