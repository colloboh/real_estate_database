create or replace procedure insert_property
(v_property_id number, v_street varchar, v_zip int, v_city varchar, v_state char, v_asking_price numeric, v_tot_size int, v_status varchar, v_date_of_const DATE, 
 v_property_type varchar, v_firm_id number, v_agent_id number)

is
 	
  	v_ErrorCode number;		--USED FOR ERROR CHECKING
	v_ErrorMsg  Varchar2(200);
	v_CurrentUser Varchar2(100);
	v_record_count  number;
	duplicate_exception  Exception;   -- User Defined Error
	e_invalid_price  EXCEPTION;       
    
    --Cursor to check for duplicates
	Cursor property_exists
	IS
	Select count(*) from PROPERTY where upper(street) = upper(v_street) AND zip = v_zip AND upper(city) = upper(v_city) AND upper(state) = upper(v_state) AND tot_size = v_tot_size;
     
	begin

	--Validation to see if property exists	
	v_record_count := 0;
  
        
	OPEN property_exists;
   	FETCH property_exists INTO v_record_count;
   	CLOSE property_exists;

   	IF v_record_count > 0 THEN
      		RAISE duplicate_exception;
    end if;
        
    /* VALIDATE ASKING PRICE  */
  If (v_asking_price > 2000000 or v_asking_price < 5000) THEN
	RAISE e_invalid_price;
  END IF;
      

	--INSERT HERE
	INSERT INTO property values
	(v_property_id, v_street, v_zip, v_city, v_state, v_asking_price, v_tot_size, v_status, v_date_of_const, 
 v_property_type, v_firm_id, v_agent_id);
    
    UPDATE property
    SET status = 'Available' WHERE status = v_status;
    
	commit;


	EXCEPTION
		
		When duplicate_exception THEN

			dbms_output.put_line ('Property exists'); 
        
        When e_invalid_price THEN
	
	        dbms_OUTPUT.PUT_LINE(TO_CHAR(v_asking_price) || ' is an invalid asking price.  ');



		WHEN OTHERS THEN
			v_ErrorCode := SQLCODE;
			v_ErrorMsg := substr(SQLERRM,1,200);
			v_CurrentUser := USER;
 	
			DBMS_OUTPUT.PUT_LINE( TO_CHAR(SYSDATE)  || v_CurrentUser 
  			|| TO_CHAR(v_ErrorCode)  ||  v_ErrorMsg);
		


END insert_property; 
/
