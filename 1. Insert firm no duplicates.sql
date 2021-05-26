create or replace procedure insert_firm
(v_firm_id number, v_street varchar, v_zip int, v_city varchar, v_state char, v_phone_num varchar, v_name varchar)
is
 	
  	v_ErrorCode number;		--USED FOR ERROR CHECKING
	v_ErrorMsg  Varchar2(200);
	v_CurrentUser Varchar2(100);
	v_record_count  number;
	duplicate_exception  Exception;   -- User Defined Error
	
    --Cursor to check for duplicates
	Cursor firm_exists
	IS
	Select count(*) from FIRM where upper(name) = upper(v_name);

	begin

	--Validation to see if firm exists	
	v_record_count := 0;
        
	OPEN firm_exists;
   	FETCH firm_exists INTO v_record_count;
   	CLOSE firm_exists;

   	IF v_record_count > 0 THEN
      		RAISE duplicate_exception;
   	END IF;

	--INSERT HERE
	INSERT INTO firm values
	(v_firm_id , v_street, v_zip, v_city, v_state, v_phone_num, v_name);


	commit;


	EXCEPTION
		
		When duplicate_exception THEN

			dbms_output.put_line ('Firm exists'); 

		WHEN OTHERS THEN
			v_ErrorCode := SQLCODE;
			v_ErrorMsg := substr(SQLERRM,1,200);
			v_CurrentUser := USER;
 	
			DBMS_OUTPUT.PUT_LINE( TO_CHAR(SYSDATE)  || v_CurrentUser 
  			|| TO_CHAR(v_ErrorCode)  ||  v_ErrorMsg);
		


END insert_firm; 
/

