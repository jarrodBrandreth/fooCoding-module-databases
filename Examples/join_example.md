# Short example on how to create and use joins, to be able to read normalized data

## Pre-requisits:
- access to a mysql-database, as a user with grants to
-- create / drop / select database
- no database 'emp'

#### Import database dump from emp.sql. This will create the source tables to be used.

#### Open a client connection the the database
Verify that the database view_data has been created;
```
 show databases;
 show tables from database emp;
```

Verify that the select returns a result :
```
 select dept_no, dept_name from emp.departments;
```

Inner join :
```
 select d.dept_name as 'Department', 
   concat(ifnull(e.first_name,''),' ', ifnull(e.last_name,'')) as 'Employee name'
   from emp.employees e 
   inner join emp.dept_manager dm on dm.emp_no = e.emp_no
   inner join emp.department d on d.dept_no = dm.dept_no
   where dm.to_date > now()
   or dm.to_date is null;
```

Add a new department :
```
 insert into emp.department 
   (dept_no, dept_name) 
   values 
   ('d010','Legal');
```

Verify that the departmant is there :
```
 select dept_no, dept_name from emp.departments;
```

Rerun the inner join : 
```
 select d.dept_name as 'Department', 
   concat(ifnull(e.first_name,''),' ', ifnull(e.last_name,'')) as 'Employee name'
   from emp.employees e 
   inner join emp.dept_manager dm on dm.emp_no = e.emp_no
   inner join emp.department d on d.dept_no = dm.dept_no
   where dm.to_date > now()
   or dm.to_date is null;
```

Outer joins :
```
## Left join :

 select d.dept_name as 'Department', 
   concat(ifnull(e.first_name,''),' ', ifnull(e.last_name,'')) as 'Employee name'
   from emp.employees e 
   left join emp.dept_manager dm on dm.emp_no = e.emp_no
   left join emp.department d on d.dept_no = dm.dept_no
   where dm.to_date > now()
   or dm.to_date is null;

## Right join :

 select d.dept_name as 'Department', 
   concat(ifnull(e.first_name,''),' ', ifnull(e.last_name,'')) as 'Employee name'
   from emp.dept_manager dm 
   right join emp.department d on d.dept_no = dm.dept_no
   left join emp.employees e on e.emp_no = dm.emp_no
   where dm.to_date > now()
   or dm.to_date is null;

## Outer join with sub-select : 

 select d.dept_name as 'Department', 
   concat(ifnull(ss.first_name,''),' ', ifnull(ss.last_name,'')) as 'Employee name'
   from emp.departments d
   left join (
     select e.first_name, e.last_name, dm.to_date, dm.dept_no
     from emp.dept_manager dm
     inner join emp.employees e on e.emp_no = dm.emp.no ) ss
   where ss.to_date > now()
   or ss.to_date is null;

## variant of the above : 
 select d.dept_name as 'Department',
    ss.name as 'Employee name'
    from emp.departments d
    left join (
      select concat(ifnull(e.first_name,''),' ', ifnull(e.last_name,'')) name,
      dm.to_date, dm.dept_no
      from emp.dept_manager dm
      inner join emp.employees e on e.emp_no = dm.emp_no ) ss
    on ss.dept_no = d.dept_no  where ss.to_date > now()
    or ss.to_date is null;
```

### Cleanup:
```
 drop database emp;
```



