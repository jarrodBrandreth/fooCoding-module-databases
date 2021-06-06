# Short example on how to create and use views, eas a method for concveeniance and security 

## Pre-requisits:
- access to a mysql-database, as a user with grants to
-- create / drop database
-- create / drop view
-- create / grant / drop user
- no database 'view_data', 'views' or user 'viewuser'@'localhost'

#### Import database dump from view_data.sql. This will create the source tables to be used.

#### Open a client connection the the database
Verify that the database view_data has been created;
```
 show databases;
```

Verify that the user 'viewuser' doesn't exist in the database :
```
 select user, host from mysql.user;
```

Create the user 'viewuser', with the password 'viewpass', and verify that it exists :
```
 create user viewuser@'localhost' identified by 'viewuser';
 show grants for viewuser@'localhost';
```

Verify that the select returns a result :
```
 select e.first_name, e.last_name, jt.name, l.city, l.country 
 from view_data.employees e 
  inner join view_data.job_title jt on e.job_id = jt.id 
  inner join view_data.locations l on e.location_id = l.id ;
```

Create a database for the view :
```
 create database views;
```

Create the view :
```
 create view views.employee_locations as
   select e.first_name, e.last_name, jt.name 'job_title', l.city, l.country 
   from view_data.employees e 
    inner join view_data.job_title jt on e.job_id = jt.id 
    inner join view_data.locations l on e.location_id = l.id ;
```

Verify that the view returns the correct result :
```
 select first_name, last_name, job_title, city, country 
  from views.employee_locations;
```

### Open a second session to the database, as the user 'viewuser', and run the selects :

List the databases that are accessable for the user :
```
 show databases;
```

Select the data from  the source tables :
```
 select e.first_name, e.last_name, jt.name, l.city, l.country
 from view_data.employees e
  inner join view_data.job_title jt on e.job_id = jt.id
  inner join view_data.locations l on e.location_id = l.id ;
```

and try to select the data from the view :
```
 select first_name, last_name, job_title, city, country 
  from views.employee_locations;
```

#### In the first session, do :
```
 grant select on views.employee_locations to viewuser@localhost;
```

#### In the second session :
- retry all sqls made as 'viewuser'.
- try updating the first_name for one of the employees.

### Cleanup:
- Exit the second session
- In the first session :
```
 revoke select on views.employee_locations from viewuser@localhost;
 drop user viewuser@'localhost';
 drop database views;
 drop database view_data;
```



