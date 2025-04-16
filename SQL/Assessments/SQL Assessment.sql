-- Question 1 :

create table worker (
   worker_id int ,
   first_name varchar(30),
   last_name varchar(25),
   salary int ,
   joining_date date,
   depatment varchar(30)
);

drop table worker ;

INSERT INTO worker (worker_id, first_name, last_name, salary, joining_date, depatment)
VALUES
(1, 'Monika', 'Arora', 100000, '2014-02-20', 'HR'),
(2, 'Niharika', 'Verma', 80000, '2014-11-06', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2014-02-20', 'HR'),
(4, 'Amitabh', 'Singh', 500000, '2014-02-20', 'Admin'),
(5, 'Vivek', 'Bhati', 500000, '2014-11-06', 'Admin'),
(6, 'Vipul', 'Diwan', 200000, '2014-11-06', 'Account'),
(7, 'Satish', 'Kumar', 75000, '2014-01-20', 'Account'),
(8, 'Geetika', 'Chauhan', 90000, '2014-11-06', 'Admin');


-- 1. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

select * from worker 
order by first_name ASC , 
depatment DESC;

-- 2.Write an SQL query to print details for Workers with the first names “Vipul” and “Satish” from the Worker table.

select * from worker 
where  first_name 
in("Vipul","Satish");

-- 3. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.

select * from worker 
where  first_name 
like('%h') and length(first_name)=6;

-- 4. Write an SQL query to print details of the Workers whose SALARY lies between 1.

select * from worker 
where salary between 0 and 100000;

-- 5. Write an SQL query to fetch duplicate records having matching data in some fields of a table.
select first_name, last_name, salary, count(*)
 from worker 
 group by first_name, last_name, salary
 having count(*) > 1 ;


-- 6. Write an SQL query to show the top 6 records of a table.

select * from worker 
limit 6 ;

-- 7. Write an SQL query to fetch the departments that have less than five people in them.

SELECT depatment
FROM worker
GROUP BY depatment
HAVING COUNT(worker_id) < 5;

-- 8. Write an SQL query to show all departments along with the number of people in there.
select depatment, count(worker_id)
 from worker
 group by depatment ;


-- 9. Write an SQL query to print the name of employees having the highest salary in each department. 

select * from worker 
order by salary desc 
limit 1  ;



-- Question 2: Open school database, then select student table and use following SQL statements. TYPE THE STATEMENT, PRESS ENTER AND NOTE THE OUTPUT 

create database School ;

use School ;

CREATE TABLE student (
    std_name VARCHAR(45),
    sex VARCHAR(8),
    percentage INT,     
    class INT,
    src VARCHAR(1),
    stream VARCHAR(25),
    DOB DATE
);


INSERT INTO student (std_id,std_name, sex, percentage, class, src, stream, DOB)
VALUES
(1001, 'Surekha joshi', 'Female', 82, 12, 'A', 'Science', '1998-03-08'),
(1002, 'Maahi agarwal', 'Female', 56, 11, 'C', 'Commerce', '2008-11-23'),
(1003, 'Sanam verma', 'Male', 59, 11, 'C', 'Commerce', '2006-06-29'),
(1004, 'Ronit kumar', 'Male', 63, 11, 'C', 'Commerce', '1997-11-05'),
(1005, 'Dipesh pulkit', 'Male', 78, 11, 'B', 'Science', '2003-09-14'),
(1006, 'Jahanvi puri', 'Female', 60, 11, 'B', 'Commerce', '2008-11-07'),
(1007, 'Sanam kumar', 'Male', 23, 12, 'F', 'Commerce', '1998-03-08'),
(1008, 'Sahil saras', 'Male', 56, 11, 'C', 'Commerce', '2008-11-07'),
(1009, 'Akshra agarwal', 'Female', 72, 12, 'B', 'Commerce', '1996-10-01'),
(1010, 'Stuti mishra', 'Female', 72, 12, 'B', 'Science', '2008-11-23'),
(1011, 'Harsh agarwal', 'Male', 42, 11, 'B', 'Science', '1998-03-08'),
(1012, 'Nikunj agarwal', 'Male', 49, 12, 'C', 'Commerce', '1998-06-28'),
(1013, 'Akriti saxena', 'Female', 89, 12, 'A', 'Science', '2008-11-23'),
(1014, 'Tani rastogo', 'Female', 82, 12, 'A', 'Science', '2008-01-23');

-- 1 To display all the records form STUDENT table.

select * from student ;

-- 2. To display any name and date of birth from the table STUDENT.

select std_name,DOB 
from student ;

-- 3. To display all students record where percentage is greater of equal to 80 FROM student table. 

select * from student 
where percentage > 80 ;

-- 4. To display student name, stream and percentage where percentage of student is more than 80 

select std_name, class ,percentage 
from student 
where percentage > 80 ;

-- 5. To display all records of science students whose percentage is more than 75 form student table.

select * from student 
where ( src = 'Science' or  percentage >= 75); 


