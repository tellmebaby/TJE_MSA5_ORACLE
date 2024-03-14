-- Active: 1709111590096@@127.0.0.1@1521@orcl@SYSTEM
--1. system 계정에 접속하는 sql
SELECT *
FROM employees;

--2. ALL_USERS 테이블에서 USERNAME 이라는 컬러이 'HR'인 USER_ID와 USERNAME을 조회하시오.
-- > HR 계정이 있는지 확인하시오.
SELECT * 
FROM all_users
WHERE username = 'HR'
;

-- 계정 잠금 해제 (계정이 있을 경우)
ALTER USER HR ACCOUNT UNLOCK;

-- 계정 생성 (계정이 없을 경우)
-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER HR IDENTIFIED BY 123456;
-- 테이블 스페이스 변경
ALTER USER HR DEFAULT TABLESPACE users;
-- 계정이 사용할 수 있는 용량 설정 (무한대)
ALTER USER HR QUOTA UNLIMITED ON users;
-- 계정에 권한 부여 
GRANT connect, resource TO HR;

-- 계정 삭제 하고 싶을 때
DROP USER HR CASCADE;

--3.  테이블 EMPLOYEES 구조를 조회하는 SQL 문을 작성하시오.
desc employees;
--3.1 테이블 EMPLOYEES 에서 EMPLOYEE_ID, FIRST_NAME 를 조회하는 SQL 문을 작성하시오.
SELECT employee_id, first_name
FROM employees;

--4. 테이블 employees에 컬럼명을 한글로 변경하시오.
-- AS (alias) : ��µǴ� �÷��� ������ ���� ��ɾ�
-- AS �����ȣ
-- AS "��� ��ȣ" ���� �ʿ��� �� "" �ȿ� ���� ����
-- AS '��� ��ȣ' (����)


SELECT employee_id AS �����ȣ
      ,first_name �̸�
      ,last_name ��
      ,email �̸���
      ,phone_number ��ȭ��ȣ
      ,hire_date �Ի�����
      ,salary �޿�
FROM employees;

SELECT job_id
FROM employees;

--5. 테이블 EMPLOYEES 의 JOB_ID를 중복된 데이터를 제거하고 조회하는 SQL 문을 작성하시오.
SELECT DISTINCT job_id
FROM employees;


--6. 테이블 EMPLOYEES 의 SALARY(급여)가 6000을 초과하는 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
-- ��� �÷��� ��ȸ�ϴ� SQL ���� �ۼ��Ͻÿ�.

SELECT *
FROM employees
WHERE salary > 6000;

--7. 테이블 EMPLOYEES 의 SALARY(급여)가 10000인 사원의 모든 컬럼을 조회하는 SQL 문을 작성하시오.
SELECT *
FROM employees
WHERE salary = 10000;

--8.���̺� EMPLOYEES �� ��� �Ӽ����� SALARY �� �������� �������� �����ϰ�,
-- FIRST_NAME �� �������� �������� �����Ͽ� ��ȸ

-- ����
-- ORDER BY �÷��� [ASC/DSEC];
-- * ASC : ��������
-- * DESC : ��������
-- * ���� : ���������� �⺻��

SELECT *
FROM employees
order by salary desc, first_name asc;

-- 9. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ
-- OR ���� : ~�Ǵ�, ~�̰ų�
-- WHERE A OR B

SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' or job_id = 'IT_PROG';

-- 10. ���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �� ����� ��� �÷��� ��ȸ
-- <����> IN Ű���带 ����Ͽ� SQL ������ �ϼ��Ͻÿ�.
SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT','IT_PROG');

-- 11.���̺� EMPLOYEES �� JOB_ID�� ��FI_ACCOUNT�� �̰ų� ��IT_PROG�� �ƴ� ����� ��� �÷��� ��ȸ
-- <����> IN Ű���带 ����Ͽ� SQL ������ �ϼ��Ͻÿ�.
-- ! ������ ��ȸ "NOT" �� ���
SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT','IT_PROG');

-- 12.���̺� EMPLOYEES �� JOB_ID�� ��IT_PROG�� �̸鼭 SALARY �� 6000 �̻��� ����� ��� �÷��� ��ȸ
-- AND ���� ������
SELECT *
FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 6000; 

-- 13.���̺� EMPLOYEES �� FIRST_NAME �� ��S���� �����ϴ� ����� ��� �÷��� ��ȸ
-- LIKE ������ : Ư�� ���� ���ԵǴ� ���� ���� ��ȸ�� ��
-- '_' : �� ���� ��ü
-- '%' : ���� ���� ��ü

SELECT *
FROM employees
WHERE FIRST_NAME LIKE 'S%';

-- 14.���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ������ ����� ��� �÷��� ��ȸ

SELECT *
FROM employees
WHERE FIRST_NAME LIKE '%s';

-- 15.���̺� EMPLOYEES �� FIRST_NAME �� ��s���� ���ԵǴ� ����� ��� �÷��� ��ȸ

SELECT *
FROM employees
WHERE FIRST_NAME LIKE '%s%';

-- 16.���̺� EMPLOYEES �� FIRST_NAME �� 5������ ����� ��� �÷��� ��ȸ
-- �ѱ��� ��ü�� �ټ��� ���� ���
-- ����Ŭ�� LENGTH  �Լ� ���

SELECT *
FROM employees
WHERE FIRST_NAME LIKE '_____';

SELECT *
FROM employees
WHERE LENGTH (FIRST_NAME) = 5;

-- 17.���̺� EMPLOYEES �� COMMISSION_PCT�� NULL �� ����� ��� �÷��� ��ȸ
-- IS NULL ���� ������

SELECT *
FROM employees
WHERE COMMISSION_PCT IS NULL ;

-- 18.���̺� EMPLOYEES �� COMMISSION_PCT�� NULL�� �ƴ� ����� ��� �÷��� ��ȸ

SELECT *
FROM employees
WHERE COMMISSION_PCT IS NOT NULL ;

-- 19.���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�� �̻��� ��� �÷��� ��ȸ
-- �Ͻ��� ����ȯ�� �̷������.

-- 1) ���ڿ� --> �Ͻ��� ����ȯ�Ͽ� ��ȸ
SELECT *
FROM employees
WHERE hire_date >= '01/JAN/04';
-- * �������� �� ���� ���ڸ� --> '04/01/01'
-- * �������� �� ���� ���ڸ� --> '04/�ù�/01'

-- 2) TO_DATE �Լ��� ��ȯ�Ͽ� ��ȸ
SELECT *
FROM employees
WHERE hire_date >= TO_DATE('04/01/01', 'YY/MM/DD')
ORDER BY hire_date ASC;

]
-- 20.���̺� EMPLOYEES �� ����� HIRE_DATE�� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE hire_date >= '01/JAN/04'
AND hire_date <= '31/DEC/05';


SELECT *
FROM employees
WHERE hire_date >=
TO_DATE('04/01/01', 'YY/MM/DD')
AND hire_date <=
TO_DATE('05/01/01', 'YY/MM/DD');


-- 21.
-- 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL 문
-- *dual?
-- : 산술 연산, 함수 결과 등을 확인해볼 수 있는 임시 테이블



SELECT CEIL(12.45), CEIL(-12.45)
FROM dual;

-- 22.
-- 12.55와 -12.55 보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL 문

SELECT FLOOR(12.45), FLOOR(-12.45)
FROM dual;


-- 23. 각 소문제에 제시된 수와 자리 수를 이용하여 반올림하는 SQL문
-- ROUND(값, 자리수)
-- : 지정한 값을, 해당 자리수에서 반올림 하시오
-- a a a a a . bbbb
-- ... -2-1.0123

-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오. → 결과 : 1
SELECT ROUND(0.54, 0)
FROM dual;

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오. → 결과 : 0.5
SELECT ROUND(0.54, 1)
FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오. → 결과 : 130
SELECT ROUND(125.67, -1)
FROM dual;

-- 125.67 을 십의 자리에서 반올림하시오. → 결과 : 100
SELECT ROUND(125.67, -2)
FROM dual;

-- 24.각 소문제에 제시된 두 수를 이용하여 나머지를 구하는 SQL문
-- MOD 함수 사용

-- 3을 8로 나눈 나머지를 구하시오. → 결과 : 3
SELECT MOD (3,8)
FROM dual;

-- 30을 4로 나눈 나머지를 구하시오. → 결과 : 2
SELECT MOD (30,4)
FROM dual;


-- 25.각 소문제에 제시된 두 수를 이용하여 제곱수를 구하는 SQL문
-- POWER 함수
-- 2의 10제곱을 구하시오. → 결과 : 1024
SELECT POWER (2,10)
FROM dual;

-- 2의 31제곱을 구하시오. → 결과 : 2147483648
SELECT POWER (2,31)
FROM dual;

-- 26.각 소문제에 제시된 수를 이용하여 제곱근을 구하는 SQL문
-- SQRT 함수
-- 2의 제곱근을 구하시오. → 결과 : 1.41421…
SELECT SQRT (2)
FROM dual;
-- 100의 제곱근을 구하시오. → 결과 : 10
SELECT SQRT (10)
FROM dual;

-- 27.각 소문제에 제시된 수와 자리 수를 이용하여 해당 수를 절삭하는 SQL문
-- TRUNC 함수
-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
SELECT TRUNC (527425.1234, 0)
FROM dual;
-- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
SELECT TRUNC (527425.1234, 1)
FROM dual;
-- 527425.1234 을 일의 자리에서 절삭하시오.
SELECT TRUNC (527425.1234, -1)
FROM dual;
-- 527425.1234 을 십의 자리에서 절삭하시오.
SELECT TRUNC (527425.1234, -2)
FROM dual;

-- 28.각 소문제에 제시된 수를 이용하여 절댓값을 구하는 SQL문
-- ABS 함수

-- 20 의 절댓값을 구하시오.
SELECT ABS (20)
FROM dual;

-- -12.456 의 절댓값을 구하시오
SELECT ABS (-12.456)
FROM dual;

--------------------문자함수----------------------------

-- 29. <예시>와 같이 문자열을 대문자, 소문자, 첫글자만 대문자로 변환하는 SQL문
-- UPPER(), LOWER(), INITCAP()
SELECT 'AlohA WoRlD~!' AS 원문
      , UPPER('AlohA WoRlD~!') AS 대문자
      , LOWER('AlohA WoRlD~!') AS 소문자
      , INITCAP('AlohA WoRlD~!') AS "첫글자만 대문자"
FROM dual;

-- 30. <예시>와 같이 문자열의 글자 수와 바이트 수를 출력하는 SQL문
-- LENGTH, LENGTHB : 문자수, 문자 바이트수 출력
-- 예시1)
SELECT LENGTH('ALOHA WORD') AS "글자 수"
      ,LENGTHB('ALOHA WORD') AS "바이트 수"
FROM dual;
-- 예시2)
SELECT LENGTH('알로하 월드') AS "글자 수"
      ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31.<예시>와 같이 각각 함수와 기호를 이용하여 두 문자열을 병합하여 출력하는 SQL문
-- CONCAT   : 두문자열 합치기
-- '' || '' : 앞뒤 문자열 합치기

SELECT CONCAT ('ALOHA', 'WORLD') AS 함수
      ,'ALOHA'||'WORLD' AS 기호
FROM dual;

-- 32.<예시>와 같이 주어진 문자열의 일부만 출력하는 SQL문
-- SUBSTR(문자열, 시작번호, 글자수) : 문자열 부분 출력
-- 'WWW.ALOHACAMPUS.COM'

SELECT SUBSTR ('WWW.ALOHACAMPUS.COM',1,3) AS "1"
      ,SUBSTR ('WWW.ALOHACAMPUS.COM',5,11) AS "2"
      ,SUBSTR ('WWW.ALOHACAMPUS.COM',-3,3) AS "3"
FROM dual;

SELECT SUBSTR ('www.알로하클래스.com',1,3) AS "1"
      ,SUBSTR ('www.알로하클래스.com',5,11) AS "2"
      ,SUBSTR ('www.알로하클래스.com',-3,3) AS "3"
FROM dual;

-- 33.<예시>와 같이 문자열에서 특정 문자의 위치를 구하는 SQL문
-- INSTR('ALOHACLASS', 'A', 몇번째부터 찾을건지, 몇번째의 문자인지)

SELECT INSTR('ALOHACLASS', 'A', 1, 1) AS "1번째 A"
      , INSTR('ALOHACLASS', 'A', 1, 2) AS "2번째 A"
      , INSTR('ALOHACLASS', 'A', 1, 3) AS "3번째 A"
      , INSTR('ALOHACLASS', 'A', 1, 4) AS "4번째 A"
FROM dual;

-- 34. <예시>와 같이 대상 문자열을 왼쪽/오른쪽에 출력하고 빈공간을 특정 문자로 채우는 SQL문
-- LPAD (왼쪽에 PADDING 해준다), RPAD (오른쪽에 PADDING 해준다.) 
-- 'ALOHACLASS'

SELECT LPAD('ALOHACLASS', 20,'#') AS "왼쪽"
      ,RPAD('ALOHACLASS', 20, '#') AS "오른쪽"
FROM dual;

-- SUBSTR 혼합 사용 예시
SELECT RPAD(SUBSTR('020415-3123456',1,8), 14, '#') 주민번호
FROM dual;

-- 35. 테이블 EMPLOYEES 의 FIRST_NAME과 HIRE_DATE 를 검색하되 <예시>와 같이 날짜 
-- 형식을 지정하는 SQL 문을 작성하시오. (HR 계정 샘플 데이터)
-- 형식 : 2024-03-04 (월) 12:34:56
-- TO_CHAR( 데이터, '날짜/숫자 형식')
-- : 특정 데이터를 문자열 형식으로 변환하는 함수

SELECT first_name AS 이름
      ,TO_CHAR(hire_date, 'YY/MM/DD (DY) HH:MI:SS') AS 입사일자
FROM employees;

-- 36. 테이블 EMPLOYEES 의 FIRST_NAME과 SALARY 를 검색하되 <예시>와 같이 날짜 
-- 형식을 지정하는 SQL 문을 작성하시오. (HR 계정 샘플 데이터)

SELECT first_name AS 이름
      ,TO_CHAR(salary, '$999,999,999') AS 급여
FROM employees;

-- 37. 문자형으로 주어진 데이터를 날짜형 데이터로 변환하는 SQL 문
-- TO_DATE

SELECT '20240304' 문자
      ,TO_DATE('20240304', 'YYYYMMDD') AS 날짜1
      ,TO_DATE('2024/03/04', 'YYYY/MM/DD') AS 날짜2
      ,TO_DATE('2024-03-04', 'YYYY-MM-DD') AS 날짜3
      ,TO_DATE('2024.03.04', 'YYYY.MM.DD') AS 날짜4
FROM dual;

-- 38.  문자형으로 주어진 데이터를 숫자형 데이터로 변환하는 SQL 문
-- TO_NUMBER
-- : 문자형 데이터를 숫자형 데이터로 변환하는 함수

SELECT '1,200,000' 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;

-- 39.  현재 날짜를 반환하는 SQL 문
-- SYSDATE 날짜함수 사용
-- 예) 어제 : SYSDATE -1 , 내일 : SYSDATE + 1

SELECT sysdate-1 AS 어제 
      , sysdate AS 오늘 
      , sysdate+1 AS 내일 
FROM dual;

-- 40. 입사일자와 오늘 날짜를 계산하여 근무달수와 근속연수를 구하는 SQL 문
-- MONTHS_BETWWEN(A,B)
-- 날짜 A부터 B까지 개월 수 차이를 반환하는 함수
-- (단, A > B 즉, A가 더 최근 날짜로 지정해야 양수로 반환)

SELECT first_name 이름
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') 오늘
      ,TRUNC (MONTHS_BETWEEN(sysdate, hire_date)) || '개월' 근무달수
      ,TRUNC (MONTHS_BETWEEN(sysdate, hire_date) / 12) || '년' 근속연수
FROM employees;

-- 41. 오늘 날짜와 6개월 후의 날짜를 출력하는 SQL 문
-- ADD_MONTHS ( 날짜, 개월 수 )
-- : 지정한 날짜로부터 해당 개월 수를

SELECT sysdate 오늘
      ,ADD_MONTHS(sysdate, 6) "6개월 후"
FROM dual;

SELECT '2024/01/31' 개강
      ,ADD_MONTHS('2024/01/31', 6) + 1 종강
FROM dual;


-- 42. 오늘 날짜와 오늘 이후 돌아오는 토요일의 날짜를 출력하는 SQL 문
-- NEXT_DAY( 날짜, 요일 )
-- :지정한 날짜 이후 돌아오는 요일을 반환하는 함수
-- 일 월 화 수 목 금 토
-- 1  2  3  4  5  6  7 

SELECT sysdate 오늘
      ,NEXT_DAY (sysdate, 7) "다음 토요일"
FROM dual;

SELECT NEXT_DAY (sysdate, 1) "다음 일요일"
      , NEXT_DAY (sysdate, 1) "다음 월요일"
      , NEXT_DAY (sysdate, 1) "다음 화요일"
      , NEXT_DAY (sysdate, 1) "다음 수요일"
      , NEXT_DAY (sysdate, 1) "다음 목요일"
      , NEXT_DAY (sysdate, 1) "다음 금요일"
      , NEXT_DAY (sysdate, 1) "다음 토요일"
 FROM dual;

-- 43.오늘 날짜와 월초, 월말 일자를 구하는 SQL 문
-- 월초 : TRUNC ( 날짜, 'MM' )
-- 월말 : LASTDAY( 날짜 )

SELECT TRUNC ( sysdate, 'MM' ) 월초
      ,sysdate 오늘
      ,LAST_DAY( sysdate ) 월말
FROM dual;

-- 44. 테이블 EMPLOYEES 의 COMMISSION_PCT 를 중복없이 검색하되, 
-- NULL 이면 0으로 조회하고 내림차순으로 정렬하는SQL 문을 작성
-- NVL( 값, 대체할 값 )
-- 중복없이 : DISTINCT
-- 내림차순 : ORDER BY DESC

/*
 * 실행순서
 - FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
 1. 테이블을 선택한다
 2. 조건에 맞는 데이터를 선택한다
 3. 그룹기준을 지정한다
 4. 그룹별로 그룹조건에 맞는 데이터를 선택하낟
 5. 조회할 컬럼을 선택한다
 6. 조회된 결과를 정렬기준에 따라 정렬한다
*/

-- ORDER BY 의 정렬기준 컬럼은, SELECT 에서 선택한 컬럼만 사용 가능하다
SELECT DISTINCT NVL ( commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY NVL ( commission_pct, 0) DESC
;

-- 죄회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다
SELECT DISTINCT NVL ( commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY "커미션(%)" DESC
;


-- 45. 테이블 EMPLOYEES 의 FIRST_NAME, SALARY, COMMISSION_PCT 속성을 이용하여 
-- <예시>와 같이 SQL 문을 작성
-- <조건>   -최종급여 = 급여 + (급여X커미션)
--          -최종급여를 기준으로 내림차순 정렬
SELECT FIRST_NAME 이름
      ,SALARY 급여
      ,NVL (COMMISSION_PCT,0) 커미션
      ,NVL (SALARY+(SALARY*COMMISSION_PCT),SALARY) 최종급여
FROM EMPLOYEES
ORDER BY SALARY DESC
;

-- 선생님 해설
-- * NVL2 ( 값, NULL 아닐 때 값, NULL 일 때 값 )
SELECT FIRST_NAME 이름
      ,SALARY 급여
      ,NVL (COMMISSION_PCT,0) 커미션
      ,NVL2 (COMMISSION_PCT, (SALARY*COMMISSION_PCT),SALARY) 최종급여
FROM EMPLOYEES
ORDER BY 최종급여 DESC
;

-- 46. 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성
-- <조건> - DECODE 함수를 이용하시오
--        - 부서명은 HR 계정의 DEPARTMENTS 테이블을 참조하시오

-- DECODE 
-- : 지정한

-- 사원 테이블 : department_id (부서번호)
SELECT first_name 이름 
      ,DECODE( department_id, 10, 'Administration',
                              20, 'Marketing',
                              30, 'Purchasing',
                              40, 'Human Resources',
                              50, 'Shipping',
                              60, 'IT',
                              70, 'Public Relations',
                              80, 'Sales',
                              90, 'Executive',
                              100, 'Finance'
     ) 부서
FROM EMPLOYEES;

-- 부서 테이블 : department_id (부서번호)
SELECT *
FROM DEPARTMENTS;

-- 47. 테이블 EMPLOYEES 의 FIRST_NAME, DEPARTMENT_ID 속성을 이용하여 <예시>와 같이 SQL 문을 작성
-- CASE 

SELECT first_name 이름
      ,CASE WHEN department_id = 10 THEN 'Administration'
            WHEN department_id = 20 THEN 'Marketing'                 
            WHEN department_id = 30 THEN 'Purchasing'                 
            WHEN department_id = 40 THEN 'Human Resources'                 
            WHEN department_id = 50 THEN 'Shipping'                 
            WHEN department_id = 60 THEN 'IT'                 
            WHEN department_id = 70 THEN 'Public Relations'                 
            WHEN department_id = 80 THEN 'Sales'                 
            WHEN department_id = 90 THEN 'Executive'                 
            WHEN department_id = 100 THEN 'Finance'    
            ELSE '부서없음'    
      END 부서
FROM employees;

-- 48. 
-- EMPLOYEES 테이블로 부터 전체 사원 수를 구하시오.
-- COUNT( 컬럼명 )
-- : 컬럼을 지정하여 NULL 을 제외한 데이터 개수를 반환하는 함수
-- * NULL 이 없는 데이터라면 어떤 컬럼을 지정하더라도 개수가 같으므로,
--   일반적으로 COUNT(*) 로 개수를 구한다.

-- COUNT(*) : NULL 도 포함하여 개수를 구함
SELECT COUNT(*) 사원수
FROM employees;

-- COUNT(컬럼) : NULL 은 제외하고 개수를 구함
SELECT COUNT(commission_pct) "성과급이 있는 사원수"
FROM EMPLOYEES;

-- 49.
-- 사원들의 최고급여와 최저급여를 구하시오.

SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM EMPLOYEES;

-- 50.
-- 사원들의 급여 합계와 평균을 구하시오.ADD
SELECT SUM(salary) 급여합계
      ,ROUND ( AVG ( salary ), 2 ) 급여평균
FROM EMPLOYEES;

-- 51.
-- 다음 <예시> 와 같이 테이블 EMPLOYEES 의 급여표준편자와 급여분산을 구하는 SQL 문을 작성

SELECT ROUND( STDDEV ( salary ), 2 ) 급여표준편차
      ,ROUND( VARIANCE( salary ), 2 ) 분산
FROM EMPLOYEES;

-- 52번
-- MS STUDENT 테이블을 생성하시오
/*
    CREATE TABLE 테이블명 (
        컬럼명1 타입    [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        컬럼명2 타입    [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        컬럼명3 타입    [DEFAULT 기본값] [NOT NULL/NULL]  [제약조건],
        ...
    );
*/
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL
    ,NAME       VARCHAR2(20)    NOT NULL
    ,CTZ_NO     CHAR(14)        NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,DEPT_NO    NUMBER          NOT NULL
    ,MJ_NO      NUMBER          NOT NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
    ,
    CONSTRAINT MS_STUDENT_PK PRIMARY KEY(ST_NO) ENABLE
);

-- UQ (고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE ( EMAIL ) ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '부서번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

/*
      테이블 삭제
      DROP TABLE 테이블명;
*/
DROP TABLE MS_STUDENT;


-- 53.
-- MS_STUDENT 테이블에 설병, 재적, 입학일자, 졸업일자 속성을 추가하시오.ADD
-- 테이블에 속성추가
-- ALTER TABLE 테이블명 ADD 컬럼명 타입 DEFAULT 기본값 [NOT NULL];

-- 성별 속성 추가
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
-- 재적 속성 추가
ALTER TABLE MS_STUDENT ADD STATUS CHAR(6) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
-- 입학일자 속성 추가
ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
-- 졸업일자 속성 추가
ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';


-- 54.
-- MS_STUDENT 테이블의 CTZ_NO 속성을 BIRTH 로 이름을 변경하고
-- 데이터 타입을 DATE 로 수정하시오.
-- 그리고, 설명도 '생년월일'로 변경하시오.

-- CTZ_NO ➡ BIRTH  이름 변경
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
-- DATE 타입으로 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
-- 설명을 '생년월일'로 변경
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';

-- 55.
-- MS_STUDENT 테이블의 학부 번호(DEPT_NO) 속성을 삭제하시오

ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;

-- 56.
-- MS_STUDENT 테이블을 삭제하시오

DROP TABLE MS_STUDENT;

-- 57.
-- 테이블 정의서 대로 학생테이블(MS_STUDENT) 를 생성하시오.
CREATE TABLE MS_STUDENT (
     ST_NO      NUMBER          NOT NULL 
    ,NAME       VARCHAR2(20)    NOT NULL
    ,BIRTH      DATE            NOT NULL
    ,EMAIL      VARCHAR2(100)   NOT NULL
    ,ADDRESS    VARCHAR2(1000)  NULL
    ,MJ_NO      NUMBER          NOT NULL
    ,GENDER     CHAR(6)         DEFAULT '기타'    NOT NULL
    ,STATUS     VARCHAR2(10)    DEFAULT '대기'    NOT NULL
    ,ADM_DATE   DATE    NULL
    ,GRD_DATE   DATE    NULL
    ,REG_DATE   DATE    DEFAULT sysdate NOT NULL
    ,UPD_DATE   DATE    DEFAULT sysdate NOT NULL
    ,ETC        VARCHAR2(1000)  DEFAULT '없음' NULL
    ,
    CONSTRAINT MS_STUDENT_PK PRIMARY KEY(ST_NO) ENABLE
);

-- UQ (고유키) 추가
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_UK1 UNIQUE ( EMAIL ) ENABLE;

COMMENT ON TABLE MS_STUDENT IS '학생들의 정보를 관리한다.';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생 번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';

COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58.
-- 데이터 삽입 (INSERT)
-- 전공번호 (NUMBER) --> CHAR(4)

ALTER TABLE MS_STUDENT MODIFY MJ_NO CHAR(4);

INSERT INTO ms_student( 
                        ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER,
                         STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC
                      )
VALUES ( '20180001', '최서아', TO_DATE('1999/10/05','YYYY/MM/DD'), 'csa@univ.ac.kr', '서울', 'I01',
         '여', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

         
-- '1999/10/05' -> TO_DATE('1999/10/05', 'YYYY/MM/DD')도 가능
-- SQL Development
DELETE FROM MS_STUDENT WHERE ST_NO = '20180001';

SELECT * FROM MS_STUDENT;


-- MS_STUDENT 데이터 추가
INSERT INTO ms_student ( 
                              ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, GENDER,
                              STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC
                        )
VALUES ( '20180001', '최서아', '1999/10/05', 'csa@univ.ac.kr', '서울', 'I01', '여', 
        '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

-- '1999/10/05' -> TO_DATE('1999/10/05', 'YYYY/MM/DD') 도 가능
-- SQL Developer 에서 INSERT 한다면, COMMIT 을 실행해줘야 LOCK 걸리지 않고 적용됨.


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210001', '박서준', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'psj@univ.ac.kr', '서울', 'B02',
         '남', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20210002', '김아윤', TO_DATE('2002/05/04', 'YYYY/MM/DD'), 'kay@univ.ac.kr', '인천', 'S01',
         '여', '재학', TO_DATE('2021/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20160001', '정수안', TO_DATE('1997/02/10', 'YYYY/MM/DD'), 'jsa@univ.ac.kr', '경남', 'J01',
         '여', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20150010', '윤도현', TO_DATE('1996/03/11', 'YYYY/MM/DD'), 'ydh@univ.ac.kr', '제주', 'K01',
         '남', '재학', TO_DATE('2016/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20130007', '안아람', TO_DATE('1994/11/24', 'YYYY/MM/DD'), 'aar@univ.ac.kr', '경기', 'Y01',
         '여', '재학', TO_DATE('2013/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, '영상예술 특기자' );


INSERT INTO MS_STUDENT ( ST_NO, NAME, BIRTH, EMAIL, ADDRESS, MJ_NO, 
                        GENDER, STATUS, ADM_DATE, GRD_DATE, REG_DATE, UPD_DATE, ETC )
VALUES ( '20110002', '한성호', TO_DATE('1992/10/07', 'YYYY/MM/DD'), 'hsh@univ.ac.kr', '서울', 'E03',
         '남', '재학', TO_DATE('2015/03/01', 'YYYY/MM/DD'), NULL, sysdate, sysdate, NULL );

-- 59. 
-- UPDATE MS_STUDENT
-- SET address = '서울'
-- , status = '휴학'
-- WHERE st_no = '20160000';

-- 1) 학생번호가 20160001 인 학생의 주소를 '서울'로,
--    재적상태를 '휴학'으로 수정하시오.
UPDATE MS_STUDENT
      SET ADDRESS = '서울'
      ,STATUS = '휴학'
WHERE ST_NO = '20160001';

SELECT * FROM MS_STUDENT;

-- 2) 학생번호가 20150010 인 학생의 주소를 '서울'로,
--    재적 상태를 '졸업', 졸업일자를 '20200220', 수정일자 현재날짜로 
--    그리고 특이사항을 '수석'으로 수정하시오.
UPDATE MS_STUDENT
      SET ADDRESS = '서울'
      ,STATUS = '졸업'
      ,GRD_DATE = '20200220'
      ,UPD_DATE = sysdate
      ,ETC = '수석'
WHERE ST_NO = '20150010';

-- 3) 학생번호가 20130007 인 학생의 재적 상태를 '졸업', 졸업일자를 '20200220', 
--    수정일자 현재날짜로 수정하시오.
UPDATE MS_STUDENT
      SET STATUS = '졸업'
      ,GRD_DATE = '20200220'
      ,UPD_DATE = sysdate
WHERE ST_NO = '20130007';

-- 4) 학생번호가 20110002 인 학생의 재적 상태를 '퇴학', 
--    수정일자를 현재날짜, 특이사항 '자진 퇴학' 으로 수정하시오.
UPDATE MS_STUDENT
      SET STATUS = '퇴학'
      ,UPD_DATE = sysdate
      ,ETC = '자진 퇴학'
WHERE ST_NO = '20110002';

-- 60.
-- 테이블에서 학번이 '20110002' 학생을 삭제하시오.
DELETE FROM MS_STUDENT
WHERE ST_NO = '20110002';

SELECT * FROM MS_STUDENT;


-- 61.
-- 모든 속성을 조회하는 SQL 문
SELECT *
FROM MS_STUDENT;

-- 62.
-- MS_STUDENT 테이블의 모든 속성을 조회하여 MS_STUDENT_BACK 테이블을 생성하는 SQL 문
-- 백업 테이블을 만들기

CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

SELECT * FROM MS_STUDENT_BACK;

-- 63.
-- MS_STUDENT 테이블의 튜플을 삭제하시오.ADD

-- 데이터삭제
DELETE FROM MS_STUDENT;

-- 데이터 및 내부 구조 삭제
TRUNCATE TABLE MS_STUDENT;

-- 구조 삭제
DROP TABLE MS_STUDENT;

-- 64.
-- MS_STUDENT_BACK 테이블의 모든 속성을 조회하여 MS_STUDENT 테이블에 삽입하는 SQL 문

INSERT INTO MS_STUDENT
SELECT * FROM MS_STUDENT_BACK;

-- 65.
-- MS_STUDENT 테이블의 성별 속성이 (‘여’, ‘남‘, ‘기타‘ ) 값만 입력가능하도록 하는 제약조건을 추가

ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STUDENT_GENDER_CHECK
CHECK ( GENDER IN ('여', '남', '기타'));

UPDATE MS_STUDENT
SET gender = '???'
;

-- * 조건으로 지정한 값이 아닌 다른 값을 입력/수정 하는 경우
-- "체크 제약조건이 위배되었습니다" 에러 발생 -> 도메인 무결성 보장

-- 66.~ 69. 숙제
/*
      집에서 해볼것
*/


-- 66.


  CREATE TABLE "HR"."MS_USER" 
   (	"USER_NO" NUMBER NOT NULL ENABLE, 
	"USER_ID" VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	"USER_PW" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	"USER_NAME" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	"BIRTH" DATE NOT NULL ENABLE, 
	"TEL" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"ADDRESS" VARCHAR2(200 BYTE), 
	"REG_DATE" DATE DEFAULT sysdate NOT NULL ENABLE, 
	"UPD_DATE" DATE DEFAULT sysdate NOT NULL ENABLE, 
	 CONSTRAINT "MS_USER_PK" PRIMARY KEY ("USER_NO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  TABLESPACE "USERS"  ENABLE, 
	 CONSTRAINT "MS_USER_UK1" UNIQUE ("USER_ID", "TEL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;

   COMMENT ON COLUMN "HR"."MS_USER"."USER_ID" IS '아이디';
   COMMENT ON COLUMN "HR"."MS_USER"."USER_PW" IS '비밀번호';
   COMMENT ON COLUMN "HR"."MS_USER"."USER_NAME" IS '이름';
   COMMENT ON COLUMN "HR"."MS_USER"."BIRTH" IS '생년월일';
   COMMENT ON COLUMN "HR"."MS_USER"."TEL" IS '전화번호';
   COMMENT ON COLUMN "HR"."MS_USER"."ADDRESS" IS '주소';
   COMMENT ON COLUMN "HR"."MS_USER"."REG_DATE" IS '등록일자';
   COMMENT ON COLUMN "HR"."MS_USER"."UPD_DATE" IS '수정일자';

-- 67.
-- MS_BOARD 테이블을 생성하시오.
CREATE TABLE MS_BOARD (
    BOARD_NO    NUMBER            NOT NULL PRIMARY KEY ,
    TITLE       VARCHAR2(200)     NOT NULL ,
    CONTENT     CLOB              NOT NULL ,
    WRITER      VARCHAR2(100)     NOT NULL ,
    HIT         NUMBER            NOT NULL ,
    LIKE_CNT    NUMBER            NOT NULL ,
    DEL_YN      CHAR(2)           NULL ,
    DEL_DATE    DATE              NULL ,
    REG_DATE    DATE              DEFAULT sysdate NOT NULL ,
    UPD_DATE    DATE              DEFAULT sysdate NOT NULL 
);
COMMENT ON TABLE MS_BOARD IS '게시판';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';


-- 68.
-- MS_FILE 테이블을 생성하시오.
CREATE TABLE MS_FILE (
      FILE_NO     NUMBER NOT NULL PRIMARY KEY ,
      BOARD_NO    NUMBER NOT NULL ,
      FILE_NAME   VARCHAR2(2000) NOT NULL ,
      FILE_DATA   BLOB  NOT NULL ,
      REG_DATE    DATE  DEFAULT sysdate NOT NULL ,
      UPD_DATE    DATE  DEFAULT sysdate NOT NULL 
);

COMMENT ON TABLE MS_FILE IS '첨부파일';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';

-- 69.
-- MS_REPLY 테이블을 생성하시오.
CREATE TABLE MS_REPLY (
    REPLY_NO    NUMBER      NOT NULL PRIMARY KEY ,
    BOARD_NO    NUMBER      NOT NULL ,
    CONTENT     VARCHAR2(2000)    NOT NULL ,
    WRITER      VARCHAR2(100)    NOT NULL ,
    DEL_YN      CHAR(2)     DEFAULT 'N' NULL ,
    DEL_DATE    DATE        NULL ,
    REG_DATE    DATE        DEFAULT sysdate NOT NULL ,
    UPD_DATE    DATE        DEFAULT sysdate NOT NULL 
);

COMMENT ON TABLE MS_REPLY IS '댓글';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';


-- 70.

-- 1. joeun, joeun2 계정 생성
-- 2. community.dmp 파일 import

-- joeun

-- 계정 생성 (계정이 없을 경우)
-- c## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER joeun IDENTIFIED BY 123456;
-- 테이블 스페이스 변경
ALTER USER joeun DEFAULT TABLESPACE users;
-- 계정이 사용할 수 있는 용량 설정 (무한대)
ALTER USER joeun QUOTA UNLIMITED ON users;
-- 계정에 권한 부여 
GRANT DBA TO joeun;

-- 덤프파일 import 하기
-- imp userid=관리자계정/비밀번호 file=덤프파일경로 fromuser=덤프소유계정 touser=임포트할계정
imp userid=system/123456 file=C:\JOEUN\ORACLE\joeun.dmp fromuser=joeun touser=joeun

-- 71.
-- joeun 계정의 데이터를 덤프파일로 export 하기
-- EXPORT

exp userid=joeun/123456 file=C:\JOEUN\ORACLE\community.dmp log=C:\JOEUN\ORACLE\community.log