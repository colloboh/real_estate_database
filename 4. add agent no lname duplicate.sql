create or replace procedure insert_agent
(v_agent_id number, v_fname  varchar, v_lname varchar, v_street varchar, v_zip int, v_city varchar, v_state char, 
 v_salary numeric, v_tot_amt_sales int, v_firm_id number)

is
 	
  	v_ErrorCode number;		--USED FOR ERROR CHECKING
	v_ErrorMsg  Varchar2(200);
	v_CurrentUser Varchar2(100);
	v_record_count  number;

  
    
    --Cursor to check for duplicates
	Cursor lname_exists
	IS
	Select count(*) from AGENT where upper(agent.lname) = upper(v_lname);
	begin

	--Validation to see if last name exists	
	v_record_count := 0;
  
        
	OPEN lname_exists;
   	FETCH lname_exists INTO v_record_count;
   	CLOSE lname_exists;

   	IF v_record_count > 0 THEN
      		dbms_output.put_line ('Last name exists'); 
   else
   begin

	--INSERT HERE
	INSERT INTO agent values
	(v_agent_id, v_fname , v_lname, v_street, v_zip, v_city, v_state, v_salary, v_tot_amt_sales, v_firm_id);
    
    UPDATE agent
    SET tot_amt_sales = 0 WHERE agent_id = v_agent_id;
    
	commit;
    
    end;
    end if;


	EXCEPTION

		WHEN OTHERS THEN
			v_ErrorCode := SQLCODE;
			v_ErrorMsg := substr(SQLERRM,1,200);
			v_CurrentUser := USER;
 	
			DBMS_OUTPUT.PUT_LINE( TO_CHAR(SYSDATE)  || v_CurrentUser 
  			|| TO_CHAR(v_ErrorCode)  ||  v_ErrorMsg);
		


END insert_agent; 
/
