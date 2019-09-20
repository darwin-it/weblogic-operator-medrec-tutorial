ALTER SESSION SET CONTAINER=pdb1;
prompt Create user medrec with connect, resource roles;
grant connect, resource to medrec_owner identified by "Medrec_Owner$01!";
alter user medrec_owner 
default tablespace users
temporary tablespace temp; 
alter user medrec_owner quota unlimited on users;
