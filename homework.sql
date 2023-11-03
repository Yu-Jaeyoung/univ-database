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


-- Q1. 전체 부서의 모든 애트리뷰트들을 검색해라.
SELECT * FROM works_for;

-- Q2. DEPARTMENT 릴레이션에서 부서 이름과 부서 번호를 검색해라.
SELECT deptname, deptno
  FROM department;

-- Q3. EMPLOYEE 릴레이션의 모든 애트리뷰트들을 검색해라.
SELECT *
  FROM employee;

-- Q4. EMPLOYEE 릴레이션에서 직급 애트리뷰트를 검색해라. (중복 제거)
SELECT DISTINCT TITLE 
  FROM employee;

-- Q5. 3번 부서에서 근무하는 모든 사원들의 이름과 직급을 검색해라.
SELECT empname, title
  FROM employee
 WHERE dno = 3;
 
-- Q6. 직급이 과장인 모든 사원들의 이름을 검색해라.
SELECT empname
  FROM employee
 WHERE title = '과장';

-- Q7. 2000년 2월 1일 이후에 입사한 모든 사원들의 이름과 입사일을 검색해라.
SELECT empname, hiredate
  FROM employee
 WHERE hiredate > '2000-02-01';

-- Q8. 직급이 과장이 아닌 모든 사원들의 이름과 직급을 검색해라.
SELECT empname, title
  FROM employee
 WHERE title != '과장';

-- Q9. 부서 2에 근무하면서 매월 250만원보다 많은 급여를 받는 모든 사람들의 이름, 직급, 급여를 검색해라.
SELECT empname, title, salary
  FROM employee
 WHERE dno = 2 AND salary > 2500000;

-- Q10. 급여가 200만원에서 300만원 사이의 모든 사원들의 이름, 직급, 급여를 검색해라.
SELECT empname, title, salary
  FROM employee
 WHERE salary BETWEEN 2000000 AND 3000000;

-- Q11. 직급이 과장이 아니면서 급여가 300만원보다 많은 모든 사람들의 이름, 직급, 급여를 검색해라.
SELECT empname, title, salary
  FROM employee
 WHERE NOT title = '과장' AND salary > 3000000;

-- Q12. 직급이 대리이거나 과장이거나 부장인 모든 사원들의 이름, 직급, 부서 번호를 검색해라.
SELECT empname, title, dno
  FROM employee
 WHERE title = '대리' OR title = '과장' OR title = '부장';

-- Q13. 2번 부서에 근무하면서 직급이 대리이거나 과장인 모든 사람들의 이름, 직급, 부서 번호를 검색해라.
SELECT empname, title, dno
  FROM employee
 WHERE dno = 2 AND (title = '대리' OR title = '과장');

-- Q14. 직급이 과장인 사원들에 대하여 이름, 현재의 급여, 급여가 10% 인상됐을 때의 값을 검색해라.
SELECT empname, salary AS "현재의 급여", salary * 1.1 AS "10% 인상" 
  FROM employee
 WHERE title = '과장';

-- Q15. 김씨 성을 가진 모든 사원들의 이름과 직급을 검색해라.
SELECT empname, title
  FROM employee
 WHERE empname LIKE '김%';
 
-- Q16. 직속 상사가 없는 가장 높은 사원의 이름과 직급을 검색해라.
SELECT empname, title
  FROM employee
 WHERE manager IS NULL;

-- Q17. 모든 사원들의 급여와 이름을 검색하여 급여에 따라 오름차순으로 정렬하라.
SELECT salary, empname
  FROM employee
 ORDER BY salary ASC;

-- Q18. 모든 사원들의 급여와 이름을 검색하여 급여에 따라 내림차순으로 정렬하라.
SELECT salary, empname
  FROM employee
 ORDER BY salary DESC;

-- Q19. 모든 사원들의 부서 번호, 급여와 이름을 검색하여 부서 번호에 대해서는 오름차순, 급여에 대해서는 내림차순으로 정렬하라.
SELECT dno, salary, empname
  FROM employee
 ORDER BY dno ASC, salary DESC;

-- Q20. 모든 사원의 평균 급여와 최대 급여를 검색하라.
SELECT AVG(salary), MAX(salary)
  FROM employee;
  
-- Q21. 3번 부서에 근무하는 사원들의 수와 평균 급여를 검색하라.
SELECT COUNT(*), AVG(salary)
  FROM employee
 WHERE dno = 3;

-- Q22. 모든 사원들에 대해서 사원들이 속한 부서번호별로 그룹화하고, 각 부서마다 부서 번호, 평균 급여와 최대 급여를 검색하라.
SELECT dno, AVG(salary), MAX(salary)
  FROM employee
 GROUP BY dno;
 
-- Q23. 부서별로 부서 번호와 급여 합계를 검색하라.
SELECT dno, SUM(salary)
  FROM employee
 GROUP BY dno;

-- Q24. 모든 사원들에 대해서 사원들이 속한 부서 번호별로 그룹화하고, 평균 급여가 2,500,000원 이상인 부서에 대하여 부서 번호, 평균 급여와 최대 급여를 검색하라.
SELECT dno, AVG(salary), MAX(salary)
  FROM employee
 GROUP BY dno
HAVING AVG(salary) >= 2500000;

-- Q25. 부서에 속한 직원들의 급여의 합계가 1000만원에서 1500만원 사이인 부서에 대해서 부서별로 부서 번호와 급여의 합계를 검색해라.
SELECT dno, SUM(salary)
  FROM employee
 GROUP BY dno
 HAVING SUM(salary) BETWEEN 10000000 AND 15000000;
 
-- Q26. 김창섭이 속한 부서이거나 개발 부서의 부서 번호를 검색하라.
SELECT dno
  FROM employee E, department D 
 WHERE E.dno = D.deptno
   AND (E.empname = '김창섭' OR D.deptname = '개발')
 GROUP BY dno;
 
-- Q27. 모든 사원의 이름과 이 사원이 속한 부서 이름을 검색하라.
SELECT E.empname, D.deptname
  FROM employee E, department D
 WHERE E.dno = D.deptno;
 
-- Q28. 모든 사원들에 대해서 사원 이름과 근무하는 부서의 층을 검색하라.
SELECT employee.empname AS "사원 이름", department.floor AS "층"
  FROM employee, department
 WHERE employee.dno = department.deptno;
 
-- Q29. 개발 부서에 근무하는 모든 사원들에 대해서 이름과 직급을 검색하라.
SELECT employee.empname AS "이름", employee.title AS "직급"
  FROM employee, department
 WHERE employee.dno = department.deptno
   AND department.deptname = '개발';
   
-- Q30. 모든 사원에 대해서 사원의 이름과 직속 상사의 이름을 검색하라.
SELECT E.empname AS "이름", EM.empname AS "직속 상사"
  FROM employee E, employee EM
 WHERE E.manager = EM.empno;

-- Q31. 모든 사원들에 대해서 소속 부서 이름, 사원의 이름, 직급, 급여를 검색하라.
SELECT deptname AS "부서이름", empname AS "이름", title AS "직급", salary AS "급여"
  FROM employee, department
 WHERE employee.dno = department.deptno;
 
-- Q32. 모든 사원들에 대해서 소속 부서 이름, 사원의 이름, 직급, 급여를 검색하라.
-- 단, 부서 이름에 대해서 오름차순, 부서이름이 같은 경우에는 SALARY에 대해서 내림차순으로 정렬하라.
SELECT deptname, empname, title, salary
  FROM employee, department
 WHERE employee.dno = department.deptno
 ORDER BY deptname ASC, salary DESC;
 
-- Q33. 영업부나 개발부에 근무하는 사원들의 이름을 검색하라.
SELECT empname
  FROM employee, department
 WHERE employee.dno = department.deptno
   AND (deptname = '영업' OR deptname = '개발');

-- Q34. 김상원과 같은 부서에 근무하는 사원들의 이름과 직급을 검색하라.
SELECT empname, title
  FROM employee
 WHERE employee.dno IN (SELECT dno
                          FROM employee
                         WHERE employee.empname = '김상원')
  AND NOT empname = '김상원';
  
-- Q35. 전체 사원들의 평균 급여보다 많이 받는 사원들의 이름, 급여, 평균 급여를 검색하라.
-- 힌트: 평균 급여 컬럼의 생성은 다음과 같이 할 수 있다.
-- (SELECT round(AVG(salary), 0) FROM employee) AS 평균급여
SELECT E.empname, E.salary, ROUND(AVG(EM.salary),0) AS "평균급여"
  FROM employee E, employee EM
 WHERE E.salary >= (SELECT ROUND(AVG(salary),0)
                      FROM employee)
 GROUP BY E.empname, E.salary;

-- Q35. 민기형
SELECT e.empname, e.salary, average
FROM employee e, (SELECT ROUND(AVG(salary),0) as average
                    FROM employee) a
WHERE e.salary > a.average;

-- Q36. 8층이나 9층에 위치한 부서에 근무하는 사원들의 이름을 검색하라.
SELECT employee.empname
  FROM department, employee
 WHERE department.deptno = employee.dno
   AND department.floor BETWEEN 8 AND 9;

-- Q37. 소속 사원이 한 명도 없는 부서에 대해서 부서 번호, 부서 이름, 층을 검색하라. 
SELECT deptno, deptname, floor
  FROM department
 WHERE department.deptno NOT IN (SELECT department.deptno
                                   FROM department, employee
                                  WHERE department.deptno = employee.dno);

-- Q37. 소속 사원이 한 명도 없는 부서에 대해서 부서 번호, 부서 이름, 층을 검색하라. 
SELECT deptno, deptname, floor
  FROM department
  LEFT OUTER JOIN employee ON employee.dno= department.deptno
 WHERE employee.empno IS NULL;