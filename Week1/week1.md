
# Database 101


### What is a Database ?
* Definition : Organized collection of data and rules about its manipulation
* Client-server architecture : E.g. (Relational) DBMS
* Files as database
* Data structure/object as database
```js
const capitals = [
  "Amsterdam",
  "Delhi",
  "Damascus",
  "Madrid"];
```
---

### Relations = Table

* What is a relation (in the following sentences)?
* Delhi is the capital of India
* Amsterdam is the capital of Netherlands
* Damascus is the capital of Syria
* Dan, 29, works in Amazon and lives in Seattle. His friend Ben who just celebrated
his 24th birthday works in Facebook and lives in Redmond.

---

### DBMS implementations

* MySQL 
* PostgreSQL
* MongoDB (NoSQL)
* Cassandra (NoSQL)

---

### MySQL

* MySQL server (runs as a service, default port: 3306)
* mysql: monitor / terminal / client (to connect to the server and execute stuff)
* mysqladmin: Administering a MySQL Server

---

### Create a database, user and grant privileges

```
# Create a database to work with

mysql> create database foodb;

# Create the user 
mysql> CREATE USER  'foouser'@'localhost' IDENTIFIED BY 'foopassword';

# Grant privileges 
mysql> GRANT ALL PRIVILEGES ON foodb.* TO 'foouser'@'localhost';

# The old way to create a new user with privileges
mysql> GRANT ALL PRIVILEGES ON foodb.* TO 'foouser'@'localhost' IDENTIFIED BY 'foopassword';

note: this is deprecated in 5.7, and might (will?) be removed in future releases

```
---

### Create Table in MySQL

## Collection of rows and columns
## SYNTAX
```
CREATE TABLE table_name (column_name, column_type [, column2_name, column2_type]);
```

* CHAR(N), VARCHAR(N)
* INT(N), FLOAT(N.N)
* DATE, DATETIME and TIMESTAMP, (set time_zone = '+03:00')
* BLOB (LOAD_FILE(filename))

---

### Fill up the table in MySQL: INSERT rows
A row (aka record or tuple) represents a single, implicitly structured data item in the table.

## SYNTAX
```
INSERT INTO table_name (column1 [, column2, column3, ...]) VALUES (value1 [, value2, value3, ...]);
```
* INSERT INTO table_name (column1 [, column2,...]) 
  SELECT column1 [, column2,...] FROM other_table
* INSERT INTO table_name SET column_name = {expr | DEFAULT}
* INSERT INTO table_name VALUES (...values...)

---

### See the content : SELECT

* FROM clause : multiple tables
* WHERE clause : Multiple conditions(AND, OR, NOT) Operators ( =, <>, BETWEEN, LIKE, IN)
* Aggregation : SUM, AVG, COUNT
* Joins : Natural join, inner join, left outer and right outer join
## Simple SYNTAX for a single table
```
SELECT */column_name FROM TABLE
WHERE condition1 AND/OR
      condition;
```
---

### INSERT and SELECT together

```
INSERT INTO 'employees' ('shop_id', 'gender', 'name', 'salary')
SELECT 3,
       LEFT(gender, 1),
       CONCAT_WS(' ', first_name, last_name),
       salary
FROM   transferred_ employees
WHERE  transfer_date > '2008-01-01';
```
---

### Uniqueness and Keys

* Primary key : must have an unique value in the column, and cannot be NULL
* Unique key : must have an unique value in the column, can be NULL

composite key : a single key spans multiple columns
---

### Relations

* One to One : Account to Employee
* One to Many : Department to Employee
* Many to Many : Project to Employee

---

### Foreign key

* A field (or collection of fields) in one table that uniquely identifies a row of another table or the same table
* In simpler words, the foreign key is defined in a second table, but it refers to the primary key or a unique key in the first table

## Database transactions
- A transaction is a set of commands that you want to treat as "one command." It has to either happen in full or not at all.

- A classical example is transferring money from one bank account to another. To do that you have first to withdraw the amount from the source account, and then deposit it to the destination account. The operation has to succeed in full. If you stop halfway, the money will be lost, and that is Very Bad.

* To start transaction:
```
mysql> start;
OR
mysql> begin transaction;
```
* To commit, use `commit;` and to abort, use `rollback;`
* Note that `autocommit` variable should be set to false for rollback to work.
```
mysql> set autocommit = 0;
```

### ACID properties

- **Atomicity** : states that database modifications must follow an “all or nothing” rule.
Each transaction is said to be “atomic.”
If one part of the transaction fails, the entire transaction fails.
- **Consistency** : states that only valid data will be written to the database. If, for some reason, a transaction is executed that violates the database’s consistency rules, the entire transaction will be rolled back, and the database will be restored to a state consistent with those rules.
- **Isolation** : requires that multiple transactions occurring at the same time not impact each other’s execution.
- **Durability** : ensures that any transaction committed to the database will not be lost. Durability is ensured through the use of database backups and transaction logs that facilitate the restoration of committed transactions in spite of any subsequent software or hardware failures.

### Normalization
Database Design following normal forms as a convention.
These normal forms build incrementally.
E.g. The database is in 3NF if it is already in 2NF and satisfied the
rules for 3rd normal form. Read [here] (https://www.studytonight.com/dbms/database-normalization.php) for more details.

#### 1NF (4 rules)
* Rule 1 : Single valued attributes (each column should have atomic value, no multiple values)
* Rule 2 : Attribute domain should not change
* Rule 3 : Unique names for attributes / columns
* Rule 4 : Order does not matter

#### 4NF
No multi-value dependency.

