--mbms 유저 만들기--------------------------------------------------
--CREATE USER mbms IDENTIFIED BY mbms;
--GRANT CONNECT, RESOURCE, DBA TO mbms;

--테이블 전부다 실행하면 자동으로 모든 테이블, 시퀀스 날리고 다시 만들어짐. 전부 실행했을때 에러 하나도 안나야 정상.

-- 테이블 재생성을 위한 드랍--------------------------------------------
DROP SEQUENCE Department_SEQ;
DROP SEQUENCE Employee_SEQ;
DROP SEQUENCE Building_SEQ;
DROP SEQUENCE Room_SEQ;
DROP SEQUENCE Reserve_history_SEQ;
DROP SEQUENCE Notice_SEQ;
DROP SEQUENCE Room_equipment_SEQ;
DROP TABLE Department CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Building CASCADE CONSTRAINTS;
DROP TABLE Room CASCADE CONSTRAINTS;
DROP TABLE Reserve_history CASCADE CONSTRAINTS;
DROP TABLE Room_Equipment CASCADE CONSTRAINTS;
DROP TABLE Notice CASCADE CONSTRAINTS;
DROP TABLE Meeting_member_list CASCADE CONSTRAINTS;
DROP TABLE Meeting_Equipment_list CASCADE CONSTRAINTS;
DROP TABLE Dept_payment CASCADE CONSTRAINTS;
DROP TABLE Competent_department  CASCADE CONSTRAINTS;

-- 테이블 생성 DDL---------------------------------------------------------------
-- Department Table Create SQL
CREATE TABLE Department
(
    dept_no        NUMBER          NOT NULL, 
    dept_name      VARCHAR2(50)    NOT NULL, 
    boss_no        VARCHAR2(50)    NULL, 
    mgr_dept_no    NUMBER          NULL, 
    CONSTRAINT DEPARTMENT_PK PRIMARY KEY (dept_no)
);
CREATE SEQUENCE Department_SEQ START WITH 10 INCREMENT BY 1;

ALTER TABLE Department
    ADD CONSTRAINT FK_Department_mgr_dept_no_Depa FOREIGN KEY (mgr_dept_no)
        REFERENCES Department (dept_no);

COMMENT ON TABLE Department IS '부서';
COMMENT ON COLUMN Department.dept_no IS '부서번호';
COMMENT ON COLUMN Department.dept_name IS '부서명';
COMMENT ON COLUMN Department.boss_no IS '부서장';
COMMENT ON COLUMN Department.mgr_dept_no IS '상위부서번호';


-- Employee Table Create SQL
CREATE TABLE Employee
(
    emp_no          VARCHAR2(50)     NOT NULL, 
    emp_pw          VARCHAR2(100)    NOT NULL, 
    emp_name        VARCHAR2(50)     NOT NULL, 
    emp_position    VARCHAR2(50)     NOT NULL, 
    emp_email       VARCHAR2(300)    NOT NULL, 
    cell_phone      VARCHAR2(15)     NOT NULL, 
    office_phone    VARCHAR2(15)     NOT NULL, 
    dept_no         NUMBER           NULL, 
    CONSTRAINT EMPLOYEE_PK PRIMARY KEY (emp_no)
);
CREATE SEQUENCE Employee_SEQ START WITH 1 INCREMENT BY 1;

ALTER TABLE Employee
    ADD CONSTRAINT FK_Employee_dept_no_Department FOREIGN KEY (dept_no)
        REFERENCES Department (dept_no);
        
COMMENT ON TABLE Employee IS '사원';
COMMENT ON COLUMN Employee.emp_no IS '사원번호';
COMMENT ON COLUMN Employee.emp_pw IS '비밀번호';
COMMENT ON COLUMN Employee.emp_name IS '이름';
COMMENT ON COLUMN Employee.emp_position IS '직급';
COMMENT ON COLUMN Employee.emp_email IS '이메일';
COMMENT ON COLUMN Employee.cell_phone IS '핸드폰번호';
COMMENT ON COLUMN Employee.office_phone IS '사무실번호';
COMMENT ON COLUMN Employee.dept_no IS '부서번호';

-- Building Table Create SQL
CREATE TABLE Building
(
    build_no      NUMBER           NOT NULL, 
    build_name    VARCHAR2(100)    NOT NULL, 
    build_addr    VARCHAR2(500)    NOT NULL, 
    build_post    VARCHAR2(50)     NOT NULL, 
    CONSTRAINT BUILDING_PK PRIMARY KEY (build_no)
);
CREATE SEQUENCE Building_SEQ START WITH 101 INCREMENT BY 1;

COMMENT ON TABLE Building IS '건물';
COMMENT ON COLUMN Building.build_no IS '건물번호';
COMMENT ON COLUMN Building.build_name IS '건물명';
COMMENT ON COLUMN Building.build_addr IS '주소';
COMMENT ON COLUMN Building.build_post IS '우편번호';

-- Room Table Create SQL
CREATE TABLE Room
(
    room_no         NUMBER            NOT NULL, 
    build_no        NUMBER            NOT NULL, 
    room_name       VARCHAR2(50)      NOT NULL, 
    room_space      NUMBER            NOT NULL, 
    room_num_emp    NUMBER            NOT NULL, 
    mgr_emp_no      VARCHAR2(50)      NULL, 
    room_img        VARCHAR2(1000)    NULL, 
    room_price      NUMBER            NOT NULL, 
    network_yn      CHAR(1)           NOT NULL, 
    room_floor      NUMBER            NOT NULL, 
    room_type       VARCHAR2(50)      NULL, 
    CONSTRAINT ROOM_PK PRIMARY KEY (room_no)
);

CREATE SEQUENCE Room_SEQ START WITH 101 INCREMENT BY 1;
ALTER TABLE Room
    ADD CONSTRAINT FK_Room_build_no_Building_buil FOREIGN KEY (build_no)
        REFERENCES Building (build_no) ON DELETE CASCADE ENABLE;--

ALTER TABLE Room
    ADD CONSTRAINT FK_Room_mgr_emp_no_Employee_em FOREIGN KEY (mgr_emp_no)
        REFERENCES Employee (emp_no) ON DELETE SET NULL ENABLE;--
        

COMMENT ON TABLE Room IS '대여장소(회의실,교육실)';
COMMENT ON COLUMN Room.room_no IS '회의실번호';
COMMENT ON COLUMN Room.build_no IS '건물번호';
COMMENT ON COLUMN Room.room_name IS '회의실명';
COMMENT ON COLUMN Room.room_space IS '규모';
COMMENT ON COLUMN Room.room_num_emp IS '수용인원';
COMMENT ON COLUMN Room.mgr_emp_no IS '담당자번호';
COMMENT ON COLUMN Room.room_img IS '회의실사진';
COMMENT ON COLUMN Room.room_price IS '시간당비용';
COMMENT ON COLUMN Room.network_yn IS 'N/W사용여부';
COMMENT ON COLUMN Room.room_floor IS '회의실위치';
COMMENT ON COLUMN Room.room_type IS '장소유형';

-- Reserve_history Table Create SQL
CREATE TABLE Reserve_history
(
    reserve_no          NUMBER           NOT NULL,
    room_no             NUMBER           NOT NULL, 
    reserve_emp_no      VARCHAR2(50)     NOT NULL, 
    start_date          DATE             NOT NULL, 
    end_date            DATE             NOT NULL, 
    approval1_yn        NUMBER           NOT NULL, 
    approval1_emp_no    VARCHAR2(50)     NULL, 
    approval1_date      DATE             NULL, 
    approval2_yn        NUMBER           NOT NULL, 
    approval2_emp_no    VARCHAR2(50)     NULL, 
    approval2_date      DATE             NULL, 
    payment_yn          NUMBER           NOT NULL, 
    payment_date        DATE             NULL, 
    reserve_date        DATE             NOT NULL, 
    reserve_price       NUMBER           NOT NULL, 
    purpose             VARCHAR2(300)    NOT NULL, 
    category            VARCHAR2(100)    NOT NULL, 
    priority            NUMBER           NOT NULL, 
    emp_count           NUMBER           NOT NULL, 
    snack_yn            CHAR(1)          NOT NULL, 
    reason              VARCHAR2(1000)   NULL,
    title               VARCHAR2(300)    NOT NULL,
    CONSTRAINT RESERVE_HISTORY_PK PRIMARY KEY (reserve_no)
);

CREATE SEQUENCE Reserve_history_SEQ START WITH 1000 INCREMENT BY 1;

ALTER TABLE Reserve_history
    ADD CONSTRAINT FK_Reserve_history_room_no_Roo FOREIGN KEY (room_no)
        REFERENCES Room (room_no);

ALTER TABLE Reserve_history
    ADD CONSTRAINT FK_Reserve_history_reserve_emp FOREIGN KEY (reserve_emp_no)
        REFERENCES Employee (emp_no);

COMMENT ON TABLE Reserve_history IS '예약내역';
COMMENT ON COLUMN Reserve_history.reserve_no IS '예약번호';
COMMENT ON COLUMN Reserve_history.room_no IS '회의실번호';
COMMENT ON COLUMN Reserve_history.reserve_emp_no IS '예약자번호';
COMMENT ON COLUMN Reserve_history.start_date IS '사용시작일';
COMMENT ON COLUMN Reserve_history.end_date IS '사용종료일';
COMMENT ON COLUMN Reserve_history.approval1_yn IS '1차결재여부';
COMMENT ON COLUMN Reserve_history.approval1_emp_no IS '1차결재자사원번호';
COMMENT ON COLUMN Reserve_history.approval1_date IS '1차결재일';
COMMENT ON COLUMN Reserve_history.approval2_yn IS '2차결재여부';
COMMENT ON COLUMN Reserve_history.approval2_emp_no IS '2차결재자사원번호';
COMMENT ON COLUMN Reserve_history.approval2_date IS '2차결재일';
COMMENT ON COLUMN Reserve_history.payment_yn IS '비용결제여부';
COMMENT ON COLUMN Reserve_history.payment_date IS '비용결제일';
COMMENT ON COLUMN Reserve_history.reserve_date IS '예약신청일';
COMMENT ON COLUMN Reserve_history.reserve_price IS '결제금액';
COMMENT ON COLUMN Reserve_history.purpose IS '회의목적';
COMMENT ON COLUMN Reserve_history.category IS '회의구분';
COMMENT ON COLUMN Reserve_history.priority IS '중요도';
COMMENT ON COLUMN Reserve_history.emp_count IS '참석인원수';
COMMENT ON COLUMN Reserve_history.snack_yn IS '간식준비여부';

-- Room_Equipment Table Create SQL
CREATE TABLE Room_Equipment
(
    room_no     NUMBER          NOT NULL, 
    eq_no       NUMBER          NOT NULL, 
    eq_name     VARCHAR2(50)    NOT NULL, 
    eq_count    NUMBER          NOT NULL, 
    CONSTRAINT ROOM_EQUIPMENT_PK PRIMARY KEY (room_no, eq_no)
);
CREATE SEQUENCE room_equipment_seq START WITH 100;

ALTER TABLE Room_Equipment
    ADD CONSTRAINT FK_Room_Equipment_room_no_Room FOREIGN KEY (room_no)
        REFERENCES Room (room_no) ON DELETE CASCADE ENABLE; --
        
COMMENT ON TABLE Room_Equipment IS '대여장소_비품현황';
COMMENT ON COLUMN Room_Equipment.room_no IS '회의실번호';
COMMENT ON COLUMN Room_Equipment.eq_no IS '비품번호';
COMMENT ON COLUMN Room_Equipment.eq_name IS '비품명';
COMMENT ON COLUMN Room_Equipment.eq_count IS '수량';



-- Notice Table Create SQL
CREATE TABLE Notice
(
    notice_no         NUMBER           NOT NULL, 
    notice_subject    VARCHAR2(100)    NOT NULL, 
    notice_content    VARCHAR2(3000)    NOT NULL, 
    writer_emp_no     VARCHAR2(50)     NOT NULL, 
    notice_date       DATE             NOT NULL, 
    CONSTRAINT NOTICE_PK PRIMARY KEY (notice_no)
);
CREATE SEQUENCE Notice_SEQ START WITH 100 INCREMENT BY 1;

ALTER TABLE Notice
    ADD CONSTRAINT FK_Notice_writer_emp_no_Employ FOREIGN KEY (writer_emp_no)
        REFERENCES Employee (emp_no);

COMMENT ON TABLE Notice IS '공지사항';
COMMENT ON COLUMN Notice.notice_no IS '공지사항번호';
COMMENT ON COLUMN Notice.notice_subject IS '제목';
COMMENT ON COLUMN Notice.notice_content IS '내용';
COMMENT ON COLUMN Notice.writer_emp_no IS '작성자사원번호';
COMMENT ON COLUMN Notice.notice_date IS '작성일';




-- Meeting_member_list Table Create SQL
CREATE TABLE Meeting_member_list
(
    reserve_no    NUMBER          NOT NULL, 
    emp_no        VARCHAR2(50)    NOT NULL, 
    dept_name     VARCHAR2(50)    NULL, 
    CONSTRAINT MEETING_MEMBER_LIST_PK PRIMARY KEY (reserve_no, emp_no)
);

ALTER TABLE Meeting_member_list
    ADD CONSTRAINT FK_Meeting_member_list_reserve FOREIGN KEY (reserve_no)
        REFERENCES Reserve_history (reserve_no);
        
ALTER TABLE Meeting_member_list
    ADD CONSTRAINT FK_Meeting_member_list_emp_no_ FOREIGN KEY (emp_no)
        REFERENCES Employee (emp_no);        

COMMENT ON TABLE Meeting_member_list IS '회의별참석자명단';
COMMENT ON COLUMN Meeting_member_list.reserve_no IS '예약번호';
COMMENT ON COLUMN Meeting_member_list.emp_no IS '사원번호';
COMMENT ON COLUMN Meeting_member_list.dept_name IS '부서명';


-- Meeting_Equipment_list Table Create SQL
CREATE TABLE Meeting_Equipment_list
(
    reserve_no    NUMBER    NOT NULL, 
    eq_no         NUMBER    NOT NULL, 
    eq_count      NUMBER    NOT NULL
);
ALTER TABLE Meeting_Equipment_list
    ADD CONSTRAINT FK_Meeting_Equipment_list_rese FOREIGN KEY (reserve_no)
        REFERENCES Reserve_history (reserve_no);

COMMENT ON TABLE Meeting_Equipment_list IS '회의별비품사용내역';
COMMENT ON COLUMN Meeting_Equipment_list.reserve_no IS '예약번호';
COMMENT ON COLUMN Meeting_Equipment_list.eq_no IS '비품번호';
COMMENT ON COLUMN Meeting_Equipment_list.eq_count IS '수량';



-- Dept_payment Table Create SQL
CREATE TABLE Dept_payment
(
    reserve_no            NUMBER     NOT NULL, 
    dept_no               NUMBER     NOT NULL, 
    dept_reserve_price    NUMBER     NOT NULL, 
    dept_payment_yn       CHAR(1)    NOT NULL, 
    CONSTRAINT DEPT_PAYMENT_PK PRIMARY KEY (reserve_no, dept_no)
);

COMMENT ON TABLE Dept_payment IS '부서별비용';
COMMENT ON COLUMN Dept_payment.reserve_no IS '예약번호';
COMMENT ON COLUMN Dept_payment.dept_no IS '부서번호';
COMMENT ON COLUMN Dept_payment.dept_reserve_price IS '결제금액';
COMMENT ON COLUMN Dept_payment.dept_payment_yn IS '비용결제여부';

ALTER TABLE Dept_payment
    ADD CONSTRAINT FK_Dept_payment_reserve_no_Res FOREIGN KEY (reserve_no)
        REFERENCES Reserve_history (reserve_no);


-- Competent_department Table Create SQL
CREATE TABLE Competent_department (
    reserve_no NUMBER REFERENCES reserve_history(reserve_no),
    dept_no NUMBER REFERENCES department(dept_no),
    emp_count NUMBER NOT NULL
);



-- 06월 27일 14시 RESERVE_HISTORY 참조 테이블 제약 조건 변경
ALTER TABLE Meeting_member_list DROP CONSTRAINT FK_Meeting_member_list_reserve ;

ALTER TABLE Meeting_member_list
    ADD CONSTRAINT FK_Meeting_member_list_reserve FOREIGN KEY (reserve_no)
        REFERENCES Reserve_history (reserve_no) ON DELETE CASCADE;
        
ALTER TABLE Meeting_Equipment_list DROP CONSTRAINT FK_Meeting_Equipment_list_rese ;

ALTER TABLE Meeting_Equipment_list
    ADD CONSTRAINT FK_Meeting_Equipment_list_rese FOREIGN KEY (reserve_no)
        REFERENCES Reserve_history (reserve_no) ON DELETE CASCADE;
        
ALTER TABLE Dept_payment DROP CONSTRAINT FK_Dept_payment_reserve_no_Res;
        
ALTER TABLE Dept_payment
    ADD CONSTRAINT FK_Dept_payment_reserve_no_Res FOREIGN KEY (reserve_no)
        REFERENCES Reserve_history (reserve_no) ON DELETE CASCADE ;
        
DROP TABLE Competent_department  CASCADE CONSTRAINTS;

CREATE TABLE Competent_department (
    reserve_no NUMBER REFERENCES reserve_history(reserve_no) ON DELETE CASCADE,
    dept_no NUMBER REFERENCES department(dept_no),
    emp_count NUMBER NOT NULL
);