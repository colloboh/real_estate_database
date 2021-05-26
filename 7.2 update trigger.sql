Create or Replace TRIGGER trigger_agent_sales
AFTER UPDATE
OF status
ON property
for each row

begin

update agent
set tot_amt_sales = tot_amt_sales + :new.asking_price
where agent_id = :new.agent_id;

EXCEPTION

when others then
raise_application_error
(-20000, 'Update failed.');

end;
/