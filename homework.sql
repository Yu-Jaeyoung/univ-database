CREATE TABLE department (
    deptno NUMBER NOT NULL,
    deptname VARCHAR2(20),
    floor NUMBER,
    PRIMARY KEY (deptno)
);

INSERT INTO department (deptno, deptname, floor) 
VALUES ('1', '영업', '8');

INSERT INTO department (deptno, deptname, floor) 
VALUES ('2', '기획', '10');

INSERT INTO department (deptno, deptname, floor) 
VALUES ('3', '개발', '9');

INSERT INTO department (deptno, deptname, floor) 
VALUES ('4', '총무', '7');

-- SELECT * from department;

CREATE TABLE employee (
    empno    NUMBER       NOT NULL,
    empname  VARCHAR2(10) NOT NULL,
    title    VARCHAR2(10) NOT NULL,
    manager  NUMBER,
    salary   NUMBER       NOT NULL,
    hiredate DATE         NOT NULL,
    dno      NUMBER       NOT NULL,
    PRIMARY KEY (empno),
    FOREIGN KEY (manager) REFERENCES employee (empno),
    FOREIGN KEY (dno) REFERENCES department (deptno)
);

INSERT INTO employee (empno, empname, title, salary, hiredate, dno)
VALUES (4377, '이성래', '사장', 5000000, '96/01/05', 2);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (3228, '김주훈', '부장', 4377, 4000000, '97/03/06', 2);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (3011, '이수민', '부장', 4377, 4000000, '96/04/03', 3);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (1234, '장건호', '부장', 4377, 4200000, '96/11/23', 1);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (3426, '박영권', '과장', 1234, 3000000, '98/07/20', 1);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (2468, '조범수', '과장', 3011, 3500000, '98/12/17', 2);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (2106, '김창섭', '대리', 3228, 2500000, '00/03/05', 2);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (1003, '조민희', '대리', 2468, 2600000,'01/02/19' , 2);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (2544, '오준석', '대리', 2468, 2700000, '01/08/25', 3);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (3427, '최종철', '사원', 1003, 1500000, '05/10/28', 3);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (1365, '김상원', '사원', 3426, 1600000, '04/02/26', 1);

INSERT INTO employee (empno, empname, title, manager, salary, hiredate, dno)
VALUES (1099, '이재원', '사원', 3426, 1800000, '03/12/21', 2);

SELECT * FROM employee;

-- UPDATE employee SET dno = 3 WHERE empno = 2468; 

CREATE TABLE project (
    projno      NUMBER      NOT NULL,
    projname    VARCHAR(20) NOT NULL,
    budget      NUMBER      NOT NULL,
    manager     NUMBER      NOT NULL,
    PRIMARY KEY (projno),
    FOREIGN KEY (manager) REFERENCES employee (empno) 
);

INSERT INTO project (projno, projname, budget, manager)
VALUES (1, '새로운 서비스', 150000000, 3228);

INSERT INTO project (projno, projname, budget, manager)
VALUES (2, '차세대 스마트팜', 500000000, 3011);

INSERT INTO project (projno, projname, budget, manager)
VALUES (3, '잘 팔아보세', 200000000, 1234);

CREATE TABLE works_for
(
    empno     NUMBER NOT NULL,
    projno    NUMBER NOT NULL,
    startdate DATE   NOT NULL,
    PRIMARY KEY (empno, projno),
    FOREIGN KEY (empno) REFERENCES employee (empno),
    FOREIGN KEY (projno) REFERENCES project (projno)
);

INSERT INTO works_for(empno, projno, startdate)
VALUES (2106, 1, '21/01/01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (2544, 2, '2021-03-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (2468, 2, '2021-03-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (1003, 2, '2021-03-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (3427, 2, '2021-03-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (1003, 3, '2021-03-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (3426, 3, '2021-01-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (1365, 3, '2021-01-01');

INSERT INTO works_for(empno, projno, startdate)
VALUES (1099, 3, '2021-01-01');

SELECT * FROM works_for;


SELECT *
  FROM department;
  
SELECT deptname, deptno
  FROM department;

SELECT *
  FROM employee;

SELECT DISTINCT TITLE 
  FROM employee;

SELECT empname, title
  FROM employee
 WHERE dno = 3;
 
SELECT empname
  FROM employee
 WHERE title = '과장';

SELECT empname, hiredate
  FROM employee
 WHERE hiredate > '2000-02-01';

SELECT empname, title
  FROM employee
 WHERE title LIKE '과장';

SELECT empname, title, salary
  FROM employee
 WHERE dno = 2 AND salary > 2500000;
 
SELECT empname, title, salary
  FROM employee
 WHERE salary BETWEEN 2000000 AND 3000000;

SELECT empname, title, salary
  FROM employee
 WHERE NOT title = '과장' AND salary > 3000000;

SELECT empname, title, dno
  FROM employee
 WHERE title = '대리' OR title = '과장' OR title = '부장';
 
SELECT empname, title, dno
  FROM employee
 WHERE dno = 2 AND (title = '대리' OR title = '과장');

SELECT empname, salary AS "현재의 급여", salary * 1.1 AS "10% 인상" 
  FROM employee
 WHERE title = '과장';

SELECT empname, title
  FROM employee
 WHERE empname LIKE '김%';
 
SELECT empname, title
  FROM employee
 WHERE manager IS NULL;

SELECT salary, empname
  FROM employee
 ORDER BY salary ASC;

SELECT salary, empname
  FROM employee
 ORDER BY salary DESC;
 
SELECT dno, salary, empname
  FROM employee
 ORDER BY dno ASC, salary DESC;
 
SELECT AVG(salary), MAX(salary)
  FROM employee;
  

SELECT COUNT(*), AVG(salary)
  FROM employee
 WHERE dno = 3;

-- 22 
SELECT dno, AVG(salary), MAX(salary)
  FROM employee
 GROUP BY dno;
 
-- 23
SELECT dno, SUM(salary)
  FROM employee
 GROUP BY dno;

-- 24
SELECT dno, AVG(salary), MAX(salary)
  FROM employee
 GROUP BY dno
HAVING AVG(salary) >= 2500000;

-- 25
SELECT dno, SUM(salary)
  FROM employee
 GROUP BY dno
 HAVING SUM(salary) BETWEEN 10000000 AND 15000000;
 
-- 26
SELECT dno
  FROM employee E, department D 
 WHERE E.dno = D.deptno
   AND (E.empname = '김창섭' OR D.deptname = '개발')
 GROUP BY dno;
 
-- 27
SELECT E.empname, D.deptname
  FROM employee E, department D
 WHERE E.dno = D.deptno;
 
-- 28
SELECT employee.empname AS "사원 이름", department.floor AS "층"
  FROM employee, department
 WHERE employee.dno = department.deptno;
 
-- 29
SELECT employee.empname AS "이름", employee.title AS "직급"
  FROM employee, department
 WHERE employee.dno = department.deptno
   AND department.deptname = '개발';
   
-- 30
SELECT E.empname AS "이름", EM.empname AS "직속 상사"
  FROM employee E, employee EM
 WHERE E.manager = EM.empno;

-- 31
SELECT deptname AS "부서이름", empname AS "이름", title AS "직급", salary AS "급여"
  FROM employee, department
 WHERE employee.dno = department.deptno;
 
-- 32
SELECT deptname, empname, title, salary
  FROM employee, department
 WHERE employee.dno = department.deptno
 ORDER BY deptname ASC, salary DESC;
 
-- 33
SELECT empname
  FROM employee, department
 WHERE employee.dno = department.deptno
   AND (deptname = '영업' OR deptname = '개발');

-- 34
SELECT empname, title
  FROM employee
 WHERE employee.dno IN (SELECT dno
                          FROM employee
                         WHERE employee.empname = '김상원')
  AND NOT empname = '김상원';
  
-- 35
SELECT E.empname, E.salary, ROUND(AVG(EM.salary),0) AS "평균급여"
  FROM employee E, employee EM
 WHERE E.salary >= (SELECT ROUND(AVG(salary),0)
                      FROM employee)
 GROUP BY E.empname, E.salary;

-- 민기형
SELECT e.empname, e.salary, average
FROM employee e, (SELECT ROUND(AVG(salary),0) as average
                    FROM employee) a
WHERE e.salary > a.average;

-- 36
SELECT employee.empname
  FROM department, employee
 WHERE department.deptno = employee.dno
   AND department.floor BETWEEN 8 AND 9;

-- 37-1
SELECT deptno, deptname, floor
  FROM department
 WHERE department.deptno NOT IN (SELECT department.deptno
                                   FROM department, employee
                                  WHERE department.deptno = employee.dno);

-- 37-2
SELECT deptno, deptname, floor
  FROM department
  LEFT OUTER JOIN employee ON employee.dno= department.deptno
 WHERE employee.empno IS NULL;