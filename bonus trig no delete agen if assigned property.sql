create or replace trigger trig_del_agent
after delete
on agent 
for each row

declare
v_count int;

begin

select count(*)
into v_count
from property
where :old.agent_id = property.agent_id;

if v_count > 0
then
raise_application_error(-20000, 'Agent still assigned to property');
end if;

end;
/