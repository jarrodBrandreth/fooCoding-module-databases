# Short example on how to create and use triggers 

We're going to create a logging / history-table for population updates in the new_world.country-table.
This way, we can see how population changes over time

## Pre-requisits:
- database 'new_world'
- a user with grants to
-- create table
-- create / drop trigger 
-- insert / update / delete on tables

#### Import database dump from new_world.sql (found in the Week1/Homework-directory), if it doesn't exist

#### Open a client connection the the database
Verify that the database new_world exists
```
 show databases;
 show tables from database new_world;
```

We create the table used to log changes to population in the contry-table:
```
create table new_world.population_log (
    countrycode char(3) references country(code),
    pop_before int(11),
    pop_after int(11),
    changed datetime default current_timestamp);
```
- countrycode is a foreign key on the column country.code
- pop_before / pop_after is defined equal to the column country.population
- changed has a default value of current timestamp


We drop the trigger, if it exists, and create our trigger:
```
drop trigger if exists new_world.population_history ;

# set the delimiter from ';' to something else, in this case '$$'
delimiter $$

create trigger new_world.pop_history
  before update on new_world.country
  for each row
  begin
    if new.population != old.population then
       insert into new_world.population_log
        (countrycode, pop_before, pop_after)
        values
        (NEW.code, OLD.population, NEW.population);
    end if;
  end;
$$

# reset delimiter 
delimiter ;
```

Code , with explanations:
```
create trigger new_world.pop_history
  before update on new_world.country			---- do this before any update
  for each row						---- execute once per updated row
  begin							---- start codeblock that should be run
    if new.population != old.population then		---- if this is true
       insert into new_world.population_log		---- insert 
        (countrycode, pop_before, pop_after)
        values
        (NEW.code, OLD.population, NEW.population);	---- old and new value
    end if;
  end;
$$
```
The NEW. and OLD. values are aliases for the old value (in the table) and the new values (in the insert)

Update population for a country, and verify that it was logged:
```
update new_world.country set population = 8900000 where code = 'SWE';
Query OK, 1 row affected (0.01 sec)

select * from new_world.population_log;
+-------------+------------+-----------+---------------------+
| countrycode | pop_before | pop_after | changed             |
+-------------+------------+-----------+---------------------+
| SWE         |    8861400 |   8900000 | 2022-01-23 19:58:27 |
+-------------+------------+-----------+---------------------+
1 row in set (0.00 sec)
```

What happens if we update something else?

### Cleanup:
```
 drop trigger new_world.population_history;
 drop table new_world.population_log;
```



