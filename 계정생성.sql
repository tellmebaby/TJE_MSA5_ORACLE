-- HR ���� ����
-- C## ���λ� ���̵� ���� ����
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- ���� ����
CREATE USER HR IDENTIFIED BY 123456;
-- ���̺� �����̽� ����
ALTER USER HR DEFAULT TABLESPACE users;
-- �뷮 ����
ALTER USER HR QUOTA UNLIMITED ON users;
-- ���� �ο�
GRANT connect, resource TO HR;