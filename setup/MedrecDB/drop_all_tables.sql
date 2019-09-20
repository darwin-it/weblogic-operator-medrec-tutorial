set heading off;
set pagesize 1000
select 'drop table ' ||table_name||' cascade constraints; ' 
from user_tables;
