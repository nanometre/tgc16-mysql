-- create new database
create database swimming_school;

-- to switch database
use swimming_school;

-- check current selected database
select DATABASE();


-- create table
-- <name of column> <data type> <options>
create table parents(
    parent_id int unsigned auto_increment primary key,
    first_name varchar(200) not null, -- not null means required
    last_name varchar(200) default '' -- default "" means empty by default
) engine = innodb;
-- `engine = innodb` is for FK to work

-- show all tables
show tables;

-- insert
-- insert into <table name> (<column1>, <column2>, ...) values (<value1>, <value2>, ...)
insert into parents (first_name, last_name) values ("Ah Kow", "Tan");

-- insert multiple
insert into parents (first_name, last_name) values 
    ("Chua Kang", "Phua"),
    ("Ah Teck", "Tan"),
    ("See Mei", "Liang");

--show all rows from a table
select * from parents;

-- creating the students table
CREATE TABLE students (
    student_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    swimming_level VARCHAR(45),
    date_of_birth DATE
) ENGINE = innodb;

-- Add in a FK
-- FK data type must match the original data type
-- use 'describe <table name>' to see what is the data type

-- step 1: create the column for the foreign key
ALTER TABLE students ADD COLUMN parent_id INT UNSIGNED;
-- step 2: setup the foreign key
ALTER TABLE students ADD CONSTRAINT fk_students_parents
    FOREIGN KEY (parent_id) REFERENCES parents(parent_id);

-- insert some students
INSERT INTO students (name, swimming_level, date_of_birth, parent_id)
    values('Xiao Kow', 'beginner', '2010-09-10', 4);

-- update
UPDATE students SET swimming_level="intermediate" WHERE student_id=1;

-- delete
DELETE from students WHERE student_id=1;

-- rename table
RENAME TABLE students TO swimming_students;

-- rename column
ALTER TABLE students RENAME COLUMN name TO first_name;