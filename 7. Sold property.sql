create or replace procedure sold_property (v_property_id number)

as	

v_ErrorCode number;		--USED FOR ERROR CHECKING
	v_ErrorMsg  Varchar2(200);
	v_CurrentUser Varchar2(100);
	v_record_count  number;
    
    
Cursor property_sold
	IS
	Select count(*) from PROPERTY where property_id = v_property_id;
     
begin

 v_record_count := 0;
 
 
OPEN property_sold;
   	FETCH property_sold INTO v_record_count;
   	CLOSE property_sold;

IF v_record_count = 0 THEN
      		 dbms_OUTPUT.PUT_LINE('Property ID not found');
    end if;
    
UPDATE property
    SET status = 'Sold' WHERE property_id = v_property_id;
    
	commit;
    
    exception
    
		WHEN OTHERS THEN
			v_ErrorCode := SQLCODE;
			v_ErrorMsg := substr(SQLERRM,1,200);
			v_CurrentUser := USER;
 	
			DBMS_OUTPUT.PUT_LINE( TO_CHAR(SYSDATE)  || v_CurrentUser 
  			|| TO_CHAR(v_ErrorCode)  ||  v_ErrorMsg);
		
    
end;
/
    